#!/bin/bash

MODEL_NAME="glm-4.5"
BACKBONE="openai"
OPENAI_BASE_URL="http://0.0.0.0:9999/v1"
OPENAI_API_KEY=""

CHECKER_URL="xxxx" # If it's empty, it redirects to OpenAI.
CHECKER_MODEL_NAME="Meta-Llama-3.1-70B-Instruct"
CHECKER_API_KEY="xxxxx"

SAVE_DIR="./eval_results"
PROC_NUM=60

MAX_NEW_TOKENS=81920
TEMPERATURE=0.6

# HLE Evaluation with GPT-4o checker
python3 evaluate.py \
    --model_name $MODEL_NAME \
    --backbone $BACKBONE \
    --openai_api_key $OPENAI_API_KEY \
    --openai_base_url $OPENAI_BASE_URL \
    --tasks hle \
    --proc_num $PROC_NUM \
    --auto_extract_answer \
    --max_new_tokens $MAX_NEW_TOKENS \
    --checker_model_name "gpt-4o" \
    --checker_url "" \
    --checker_api_key $CHECKER_API_KEY \
    --temperature $TEMPERATURE \
    --stream

# LiveCodeBench Evaluation (2407-2501)
python3 evaluate.py \
    --model_name $MODEL_NAME \
    --backbone $BACKBONE \
    --openai_api_key $OPENAI_API_KEY \
    --openai_base_url $OPENAI_BASE_URL \
    --save_dir $SAVE_DIR \
    --tasks lcb \
    --lcb_date 2407_2501 \
    --proc_num $PROC_NUM \
    --auto_extract_answer \
    --max_new_tokens $MAX_NEW_TOKENS \
    --temperature $TEMPERATURE \
    --stream 

# LiveCodeBench v6 Evaluation
python3 evaluate.py \
    --model_name $MODEL_NAME \
    --backbone $BACKBONE \
    --openai_api_key $OPENAI_API_KEY \
    --openai_base_url $OPENAI_BASE_URL \
    --save_dir $SAVE_DIR \
    --tasks lcb \
    --proc_num $PROC_NUM \
    --auto_extract_answer \
    --max_new_tokens $MAX_NEW_TOKENS \
    --lcb_date v6 \
    --temperature $TEMPERATURE \
    --stream 

# AIME 2025 Evaluation
python3 evaluate.py \
    --model_name $MODEL_NAME \
    --backbone $BACKBONE \
    --openai_api_key $OPENAI_API_KEY \
    --openai_base_url $OPENAI_BASE_URL \
    --save_dir $SAVE_DIR \
    --tasks aime2025 \
    --proc_num $PROC_NUM \
    --auto_extract_answer \
    --max_new_tokens $MAX_NEW_TOKENS \
    --checker_model_name $CHECKER_MODEL_NAME \
    --checker_url $CHECKER_URL \
    --temperature $TEMPERATURE \
    --stream

# GPQA Evaluation
python3 evaluate.py \
    --model_name $MODEL_NAME \
    --backbone $BACKBONE \
    --openai_api_key $OPENAI_API_KEY \
    --openai_base_url $OPENAI_BASE_URL \
    --save_dir $SAVE_DIR \
    --tasks gpqa \
    --proc_num $PROC_NUM \
    --auto_extract_answer \
    --max_new_tokens $MAX_NEW_TOKENS \
    --checker_model_name $CHECKER_MODEL_NAME \
    --checker_url $CHECKER_URL \
    --temperature $TEMPERATURE \
    --stream

# MATH 500 Evaluation
python3 evaluate.py \
    --model_name $MODEL_NAME \
    --backbone $BACKBONE \
    --openai_api_key $OPENAI_API_KEY \
    --openai_base_url $OPENAI_BASE_URL \
    --save_dir $SAVE_DIR \
    --tasks math500 \
    --proc_num $PROC_NUM \
    --auto_extract_answer \
    --max_new_tokens $MAX_NEW_TOKENS \
    --checker_model_name $CHECKER_MODEL_NAME \
    --checker_url $CHECKER_URL \
    --temperature $TEMPERATURE \
    --stream

# MMLU Pro Evaluation
python3 evaluate.py \
    --model_name $MODEL_NAME \
    --backbone $BACKBONE \
    --openai_api_key $OPENAI_API_KEY \
    --openai_base_url $OPENAI_BASE_URL \
    --save_dir $SAVE_DIR \
    --tasks mmlu_pro \
    --proc_num $PROC_NUM \
    --auto_extract_answer \
    --max_new_tokens $MAX_NEW_TOKENS \
    --checker_model_name $CHECKER_MODEL_NAME \
    --checker_url $CHECKER_URL \
    --temperature $TEMPERATURE \
    --stream

# SciCode Evaluation
python3 evaluate.py \
    --model_name $MODEL_NAME \
    --backbone $BACKBONE \
    --openai_api_key $OPENAI_API_KEY \
    --openai_base_url $OPENAI_BASE_URL \
    --save_dir $SAVE_DIR \
    --tasks scicode \
    --proc_num $PROC_NUM \
    --auto_extract_answer \
    --max_new_tokens $MAX_NEW_TOKENS \
    --checker_model_name $CHECKER_MODEL_NAME \
    --checker_url $CHECKER_URL \
    --temperature $TEMPERATURE \
    --stream