export CUDA_VISIBLE_DEVICES=5,6,7

docker run --runtime nvidia \
    --gpus \"device=${CUDA_VISIBLE_DEVICES}\" \
    -v ~/.cache/huggingface:/root/.cache/huggingface \
    --env "HUGGING_FACE_HUB_TOKEN=${HUGGING_FACE_HUB_TOKEN}" \
    -p 8000:8000 \
    --ipc=host \
    vllm/vllm-openai:latest \
    --model mistralai/Mistral-7B-v0.1
