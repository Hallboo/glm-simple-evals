#!/bin/bash

source .venv/bin/activate

tasks="$1"

MODEL_NAME="glm-4.6"  # or "glm-4.5-air"

#For zai-sdk
BACKBONE="openai"
ZAI_API_KEY="Your API key from https://bigmodel.cn/"
OPENAI_BASE_URL="http://0.0.0.0:8000/v1" # The base url of the openai api need to be set when using openai-sdk, zai-sdk is not needed
OPENAI_API_KEY="anonymous" # The api key of the openai api need to be set when using openai-sdk, zai-sdk is not needed

# For openai-sdk
# BACKBONE="openai"
# OPENAI_BASE_URL="https://open.bigmodel.cn/api/paas/v4/" # The base url of the openai api
# OPENAI_API_KEY="Your API key from https://bigmodel.cn/" # The api key of the openai api

# CHECKER_URL="172.16.64.156:8000/v1" # The checker model's url"  # Like http://0.0.0.0:8000/v1
CHECKER_URL="$OPENAI_BASE_URL"
CHECKER_MODEL_NAME=glm-4.6 # "Meta-Llama-3.1-70B-Instruct"  # "Meta-Llama-3.1-70B-Instruct" or "gpt-4o"

SAVE_DIR="outputs"
PROC_NUM=64  # The number of processes to run the evaluation

MAX_NEW_TOKENS=128000  # The max new tokens of the evaluation
TEMPERATURE=1.0  # The temperature of the evaluation
# DEBUG_ARGS="--debug"
DEBUG_ARGS=""

if [ "$tasks" == "aime2025" ]; then
    python3 evaluate.py \
        --model_name "$MODEL_NAME" \
        --backbone "$BACKBONE" \
        --openai_api_key "$OPENAI_API_KEY" \
        --openai_base_url "$OPENAI_BASE_URL" \
        --save_dir "$SAVE_DIR" \
        --tasks aime2025 \
        --proc_num "$PROC_NUM" \
        --checker_model_name "$CHECKER_MODEL_NAME" \
        --checker_url "$CHECKER_URL" \
        --auto_extract_answer \
        --max_new_tokens "$MAX_NEW_TOKENS" \
        --stream \
        $DEBUG_ARGS
fi

if [ "$tasks" == "gpqa" ]; then
    # GPQA Evaluation
    python3 evaluate.py \
        --model_name "$MODEL_NAME" \
        --backbone "$BACKBONE" \
        --openai_api_key "$OPENAI_API_KEY" \
        --openai_base_url "$OPENAI_BASE_URL" \
        --save_dir "$SAVE_DIR" \
        --tasks gpqa \
        --proc_num "$PROC_NUM" \
        --auto_extract_answer \
        --max_new_tokens "$MAX_NEW_TOKENS" \
        --checker_model_name "$CHECKER_MODEL_NAME" \
        --checker_url "$CHECKER_URL" \
        --temperature "$TEMPERATURE" \
        --stream \
        $DEBUG_ARGS
fi

if [ "$tasks" == "hle" ]; then
    python3 evaluate.py \
        --model_name "$MODEL_NAME" \
        --backbone "$BACKBONE" \
        --openai_api_key "$OPENAI_API_KEY" \
        --openai_base_url "$OPENAI_BASE_URL" \
        --tasks hle \
        --save_dir "$SAVE_DIR" \
        --proc_num "$PROC_NUM" \
        --auto_extract_answer \
        --max_new_tokens "$MAX_NEW_TOKENS" \
        --checker_model_name "$CHECKER_MODEL_NAME" \
        --checker_url "$CHECKER_URL" \
        --temperature "$TEMPERATURE" \
        --stream \
        $DEBUG_ARGS
fi

if [ "$tasks" == "lcb_2407_2501" ]; then
    # LiveCodeBench Evaluation (2407-2501)
    python3 evaluate.py \
        --model_name "$MODEL_NAME" \
        --backbone "$BACKBONE" \
        --openai_api_key "$OPENAI_API_KEY" \
        --openai_base_url "$OPENAI_BASE_URL" \
        --save_dir "$SAVE_DIR" \
        --tasks lcb \
        --lcb_date 2407_2501 \
        --proc_num "$PROC_NUM" \
        --auto_extract_answer \
        --max_new_tokens "$MAX_NEW_TOKENS" \
        --temperature "$TEMPERATURE" \
        --top_p 0.95 \
        --stream \
        $DEBUG_ARGS
fi

if [ "$tasks" == "lcb_v6" ]; then
    # LiveCodeBench v6 Evaluation
    python3 evaluate.py \
        --model_name "$MODEL_NAME" \
        --backbone "$BACKBONE" \
        --openai_api_key "$OPENAI_API_KEY" \
        --openai_base_url "$OPENAI_BASE_URL" \
        --save_dir "$SAVE_DIR" \
        --tasks lcb \
        --proc_num "$PROC_NUM" \
        --auto_extract_answer \
        --max_new_tokens "$MAX_NEW_TOKENS" \
        --lcb_date v6 \
        --temperature "$TEMPERATURE" \
        --top_p 0.95 \
        --stream \
        $DEBUG_ARGS
fi

if [ "$tasks" == "math500" ]; then
    # MATH 500 Evaluation
    python3 evaluate.py \
        --model_name "$MODEL_NAME" \
        --backbone "$BACKBONE" \
        --openai_api_key "$OPENAI_API_KEY" \
        --openai_base_url "$OPENAI_BASE_URL" \
        --save_dir "$SAVE_DIR" \
        --tasks math500 \
        --proc_num "$PROC_NUM" \
        --auto_extract_answer \
        --max_new_tokens "$MAX_NEW_TOKENS" \
        --checker_model_name "$CHECKER_MODEL_NAME" \
        --checker_url "$CHECKER_URL" \
        --temperature "$TEMPERATURE" \
        --stream \
        $DEBUG_ARGS
fi

if [ "$tasks" == "mmlu_pro" ]; then
    # MMLU Pro Evaluation
    python3 evaluate.py \
        --model_name "$MODEL_NAME" \
        --backbone "$BACKBONE" \
        --openai_api_key "$OPENAI_API_KEY" \
        --openai_base_url "$OPENAI_BASE_URL" \
        --save_dir "$SAVE_DIR" \
        --tasks mmlu_pro \
        --proc_num "$PROC_NUM" \
        --auto_extract_answer \
        --max_new_tokens "$MAX_NEW_TOKENS" \
        --checker_model_name "$CHECKER_MODEL_NAME" \
        --checker_url "$CHECKER_URL" \
        --temperature "$TEMPERATURE" \
        --stream \
        $DEBUG_ARGS
fi

if [ "$tasks" == "scicode" ]; then
    # SciCode Evaluation
    python3 evaluate.py \
        --model_name "$MODEL_NAME" \
        --backbone "$BACKBONE" \
        --openai_api_key "$OPENAI_API_KEY" \
        --openai_base_url "$OPENAI_BASE_URL" \
        --save_dir "$SAVE_DIR" \
        --tasks scicode \
        --proc_num "$PROC_NUM" \
        --auto_extract_answer \
        --max_new_tokens "$MAX_NEW_TOKENS" \
        --checker_model_name "$CHECKER_MODEL_NAME" \
        --checker_url "$CHECKER_URL" \
        --temperature "$TEMPERATURE" \
        --stream \
        $DEBUG_ARGS
fi
