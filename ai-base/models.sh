#!/bin/bash

BASE_DIR="/glacier/ai/"

CHECKPOINTS_DIR="${BASE_DIR}/models/checkpoints/"
VAE_DIR="${BASE_DIR}/models/vae/"
CONTROLNET_DIR="${BASE_DIR}/models/controlnet/"
STYLE_MODELS_DIR="${BASE_DIR}/models/style_models/"
LORAS_DIR="${BASE_DIR}/models/loras/"
CLIP_VISION_DIR="${BASE_DIR}/models/clip_vision/"
UPSCALE_MODELS_DIR="${BASE_DIR}/models/upscale_models/"
GLIGEN_DIR="${BASE_DIR}/models/gligen/"

mkdir -p "${CHECKPOINTS_DIR}"
mkdir -p "${VAE_DIR}"
mkdir -p "${CONTROLNET_DIR}"
mkdir -p "${STYLE_MODELS_DIR}"
mkdir -p "${LORAS_DIR}"
mkdir -p "${CLIP_VISION_DIR}"
mkdir -p "${UPSCALE_MODELS_DIR}"
mkdir -p "${GLIGEN_DIR}"

# SDXL
wget -c https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors -P "${CHECKPOINTS_DIR}"
wget -c https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors -P "${CHECKPOINTS_DIR}"
wget -c https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0_0.9vae.safetensors -P "${CHECKPOINTS_DIR}"
# SD1.5
wget -c https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt -P "${CHECKPOINTS_DIR}"
wget -c https://huggingface.co/stabilityai/stable-diffusion-2-1-base/resolve/main/v2-1_512-ema-pruned.safetensors -P "${CHECKPOINTS_DIR}"
wget -c https://huggingface.co/stabilityai/stable-diffusion-2-1/resolve/main/v2-1_768-ema-pruned.safetensors -P "${CHECKPOINTS_DIR}"
# Some SD1.5 anime style
wget -c https://huggingface.co/WarriorMama777/OrangeMixs/resolve/main/Models/AbyssOrangeMix2/AbyssOrangeMix2_hard.safetensors -P "${CHECKPOINTS_DIR}"
wget -c https://huggingface.co/WarriorMama777/OrangeMixs/resolve/main/Models/AbyssOrangeMix3/AOM3A1_orangemixs.safetensors -P "${CHECKPOINTS_DIR}"
wget -c https://huggingface.co/WarriorMama777/OrangeMixs/resolve/main/Models/AbyssOrangeMix3/AOM3A3_orangemixs.safetensors -P "${CHECKPOINTS_DIR}"
wget -c https://huggingface.co/Linaqruf/anything-v3.0/resolve/main/anything-v3-fp16-pruned.safetensors -P "${CHECKPOINTS_DIR}"
# Waifu Diffusion 1.5 (anime style SD2.x 768-v)
wget -c https://huggingface.co/waifu-diffusion/wd-1-5-beta2/resolve/main/checkpoints/wd-1-5-beta2-fp16.safetensors -P "${CHECKPOINTS_DIR}"
# unCLIP models
wget -c https://huggingface.co/comfyanonymous/illuminatiDiffusionV1_v11_unCLIP/resolve/main/illuminatiDiffusionV1_v11-unclip-h-fp16.safetensors -P "${CHECKPOINTS_DIR}"
wget -c https://huggingface.co/comfyanonymous/wd-1.5-beta2_unCLIP/resolve/main/wd-1-5-beta2-aesthetic-unclip-h-fp16.safetensors -P "${CHECKPOINTS_DIR}"
# ---
# VAE
wget -c https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors -P "${VAE_DIR}"
wget -c https://huggingface.co/WarriorMama777/OrangeMixs/resolve/main/VAEs/orangemix.vae.pt -P "${VAE_DIR}"
wget -c https://huggingface.co/hakurei/waifu-diffusion-v1-4/resolve/main/vae/kl-f8-anime2.ckpt -P "${VAE_DIR}"
# Loras
wget -c https://civitai.com/api/download/models/10350 -O "${LORAS_DIR}"theovercomer8sContrastFix_sd21768.safetensors
wget -c https://civitai.com/api/download/models/10638 -O "${LORAS_DIR}"theovercomer8sContrastFix_sd15.safetensors
# T2I-Adapter
wget -c https://huggingface.co/TencentARC/T2I-Adapter/resolve/main/models/t2iadapter_depth_sd14v1.pth -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/TencentARC/T2I-Adapter/resolve/main/models/t2iadapter_seg_sd14v1.pth -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/TencentARC/T2I-Adapter/resolve/main/models/t2iadapter_sketch_sd14v1.pth -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/TencentARC/T2I-Adapter/resolve/main/models/t2iadapter_keypose_sd14v1.pth -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/TencentARC/T2I-Adapter/resolve/main/models/t2iadapter_openpose_sd14v1.pth -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/TencentARC/T2I-Adapter/resolve/main/models/t2iadapter_color_sd14/v1.pth -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/TencentARC/T2I-Adapter/resolve/main/models/t2iadapter_canny_sd14v1.pth -P "${CONTROLNET_DIR}"
# T2I Styles Model
wget -c https://huggingface.co/TencentARC/T2I-Adapter/resolve/main/models/t2iadapter_style_sd14v1.pth -P "${STYLE_MODELS_DIR}"
# CLIPVision model (needed for styles model)
wget -c https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/pytorch_model.bin -O "${CLIP_VISION_DIR}"clip_vit14.bin
# ControlNet
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11e_sd15_ip2p_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11e_sd15_shuffle_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_canny_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11f1p_sd15_depth_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_inpaint_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/thibaud/controlnet-sd21/resolve/main/control_v11p_sd21_lineart.safetensors -P "${CONTROLNET_DIR}"
#wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_lineart_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_mlsd_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_normalbae_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_openpose_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_scribble_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_seg_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15_softedge_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11p_sd15s2_lineart_anime_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/comfyanonymous/ControlNet-v1-1_fp16_safetensors/resolve/main/control_v11u_sd15_tile_fp16.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/thibaud/controlnet-openpose-sdxl-1.0/resolve/main/OpenPoseXL2.safetensors -P "${CONTROLNET_DIR}"
# https://huggingface.co/stabilityai/control-lora
wget -c https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-canny-rank256.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-depth-rank256.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-recolor-rank256.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-sketch-rank256.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank128/control-lora-canny-rank128.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank128/control-lora-depth-rank128.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank128/control-lora-recolor-rank128.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank128/control-lora-sketch-rank128-metadata.safetensors -P "${CONTROLNET_DIR}"
wget -c https://huggingface.co/thibaud/controlnet-openpose-sdxl-1.0/resolve/main/diffusion_pytorch_model.bin -O "${CONTROLNET_DIR}"OpenPoseXL2.bin
# GLIGEN
wget -c https://huggingface.co/comfyanonymous/GLIGEN_pruned_safetensors/resolve/main/gligen_sd14_textbox_pruned_fp16.safetensors -P "${GLIGEN_DIR}"
# ESRGAN upscale model
wget -c https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth -P "${UPSCALE_MODELS_DIR}"
wget -c https://huggingface.co/sberbank-ai/Real-ESRGAN/resolve/main/RealESRGAN_x2.pth -P "${UPSCALE_MODELS_DIR}"
wget -c https://huggingface.co/sberbank-ai/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth -P "${UPSCALE_MODELS_DIR}"
