# GLM-4.6 Model Evaluation Guide

This guide explains how to reproduce the GLM-4.6 model evaluation metrics using the `glm-simple-evals` repository.

We recommend the following two approaches for GLM-4.6 model evaluation.

## Local Deployment

We recommend using the `sglang` inference framework for local model deployment and validation.

**Note**: When using the latest version of `sglang` or its latest Docker image, you may encounter occasional errors that result in lower evaluation scores. Apply the [patch](https://github.com/THUDM/slime/blob/main/docker/patch/latest/sglang.patch) to fix these issues.

Alternatively, use the `slimerl/slime:20251015-v1` [Docker image](https://hub.docker.com/r/slimerl/slime/tags) to deploy the inference service.

Example startup script:
```bash
python3 -m sglang.launch_server \
    --model-path zai-org/GLM-4.6-FP8 \
    --host 0.0.0.0 \
    --port 9999 \
    --tp 8 \
    --max-running-requests 256 \
    --speculative-algorithm EAGLE \
    --speculative-num-steps 2 \
    --speculative-eagle-topk 1 \
    --speculative-num-draft-tokens 3
```

For evaluation commands, see the [local evaluation example](local_eval_example.sh).

## Cloud Service

We recommend accessing the GLM-4.6 service through the Z.AI API platform. For detailed usage instructions, refer to the [official documentation](https://docs.z.ai/guides/llm/glm-4.6).

**Note**: The cloud service may experience intermittent interruptions during high-traffic periods, which may cause benchmark evaluation results to be slightly lower than official metrics.

For evaluation commands, see the [Z.AI evaluation example](zai_eval_example.sh).