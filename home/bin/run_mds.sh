#!/bin/bash
# 切换到魔导书的绝对路径（处理了中文和空格）
cd "/mnt/E/ComfyUI-aki-v3/画师串管理小工具v3/魔导书/v2"

# 如果万一 venv 文件夹没了，会自动重新创建
if [ ! -d "venv" ]; then
    echo "未检测到 venv 环境，正在初始化..."
    python -m venv venv
fi

# 激活虚拟环境并启动
source venv/bin/activate
python launch.py
