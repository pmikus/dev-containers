#!/bin/bash

source /workspace/venv/bin/activate

cd /workspace/ComfyUI
python3 main.py --listen 0.0.0.0 &
