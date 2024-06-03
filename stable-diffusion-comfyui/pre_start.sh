#!/bin/bash

source /workspace/venv/bin/activate
rsync -au --remove-source-files /ComfyUI/ /workspace/ComfyUI/
ln -s /comfy-models/* /workspace/ComfyUI/models/checkpoints/

cd /workspace/ComfyUI
python3 main.py --listen --port 3000 &
