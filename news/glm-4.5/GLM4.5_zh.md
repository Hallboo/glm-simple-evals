# GLM-4.5 模型评测指南

本文档说明如何使用 `glm-simple-evals` 仓库复现 GLM-4.5 模型的评测指标结果。

推荐使用以下两种方式进行 GLM-4.5 模型评测。

## 本地部署

推荐使用 `sglang` 推理框架进行本地模型部署和验证。

**注意**：使用 `sglang` 最新版本或最新镜像时，可能出现偶发错误导致评测结果偏低，需要应用[补丁](https://github.com/THUDM/slime/blob/main/docker/patch/latest/sglang.patch)修复。

或者使用 `slimerl/slime:20251015-v1` [Docker 镜像](https://hub.docker.com/r/slimerl/slime/tags)部署推理服务。

启动脚本示例：
```bash
python3 -m sglang.launch_server \
    --model-path zai-org/GLM-4.5-FP8 \
    --host 0.0.0.0 \
    --port 9999 \
    --tp 8 \
    --max-running-requests 256 \
    --speculative-algorithm EAGLE \
    --speculative-num-steps 2 \
    --speculative-eagle-topk 1 \
    --speculative-num-draft-tokens 3
```

评测命令请参考[本地评测示例](local_eval_example.sh)。

## 线上服务

推荐通过智谱 API 平台调用 GLM-4.5 服务，详细使用说明请参考[官方文档](https://docs.bigmodel.cn/cn/guide/models/text/glm-4.5)。

**注意**：线上服务在高并发期间可能出现间歇性中断，导致基准评测结果略低于官方指标。

评测命令请参考[Z.AI评测示例](zai_eval_example.sh)。