import time
import traceback
from typing import Optional
from openai import OpenAI
from utils.types import MessageList, SamplerBase


class OpenAISampler(SamplerBase):
    """
    Sample from TGI's completion API
    """

    def __init__(
        self,
        url: str = "",
        model: str = "glm-4.5",
        api_key: str = "",
        system_message: Optional[str] = None,
        temperature: float = 0.0,
        max_tokens: int = 4096,
        stream: bool = False,
        top_p: float = 1.0,
        retry: int = 50,
        extra_body: Optional[dict] = None,
    ):
        self.system_message = system_message
        self.temperature = temperature
        self.max_tokens = max_tokens
        self.url = url
        self.model = model
        if not url:
            self.client = OpenAI(api_key=api_key, timeout=360)
        else:
            self.client = OpenAI(api_key=api_key, base_url=url, timeout=360)
        self.stream = stream
        self.top_p = top_p
        self.retry = retry
        self.extra_body = extra_body or {}

    def get_resp(self, message_list, top_p=-1, temperature=-1):
        temperature = temperature if temperature > 0 else self.temperature
        top_p = top_p if top_p > 0 else self.top_p

        for i in range(self.retry):
            try:
                extra_body = self.extra_body.copy()
                chat_completion = self.client.chat.completions.create(
                    messages=message_list,
                    model=self.model,
                    temperature=self.temperature,
                    max_tokens=self.max_tokens,
                    top_p=top_p,
                    extra_body=extra_body,
                )
                content = chat_completion.choices[0].message.content or None
                if content is not None:
                    return content

                # content is None，继续重试
                if i < self.retry - 1:
                    print(f"content is None, retry ... index {i}")
                    time.sleep(1)
                    continue
                else:
                    # 最后一次重试也失败了，返回空字符串
                    print(f"content is None after {self.retry} retries")
                    return ""
            except Exception as e:
                print(f"Exception: {e}\nTraceback: {traceback.format_exc()}")
                time.sleep(1)
                continue
        print(f"failed, last exception: {e if 'e' in locals() else ''}")
        return ""

    def get_resp_stream(self, message_list, top_p=-1, temperature=-1):
        temperature = temperature if temperature > 0 else self.temperature
        top_p = top_p if top_p > 0 else self.top_p

        final = ""
        reasoning = ""
        for _ in range(50):
            try:
                chat_completion_res = self.client.chat.completions.create(
                    model=self.model,
                    messages=message_list,
                    stream=True,
                    max_tokens=self.max_tokens,
                    temperature=temperature,
                    top_p=top_p,
                )
                for chunk in chat_completion_res:
                    if chunk.choices[0].delta.reasoning_content:
                        reasoning += chunk.choices[0].delta.reasoning_content
                    if chunk.choices[0].delta.content:
                        final += chunk.choices[0].delta.content
                break
            except Exception as e:
                final = ""
                print(f"Exception: {e}\nTraceback: {traceback.format_exc()}")
                time.sleep(5)
                continue

        if final == "" and reasoning == "":
            print(
                f"failed in get_resp_stream for 50 times, last exception: {e if 'e' in locals() else ''}"
            )
            return ""

        content = ""
        if final:
            content = final
        else:
            content = reasoning[:-512].strip() if reasoning else ""

        return content

    def __call__(self, message_list: MessageList, top_p=-1, temperature=-1) -> str:
        if self.system_message:
            message_list = [
                {"role": "system", "content": self.system_message}
            ] + message_list
        if not self.stream:
            return self.get_resp(message_list, top_p, temperature)
        else:
            return self.get_resp_stream(message_list, top_p, temperature)
