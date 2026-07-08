#!/bin/bash
cd "/mnt/E/Comfyui小工具/画师串管理小工具v3/魔导书/v2"

# 如果 venv 不存在则创建
if [ ! -d "venv" ]; then
  echo "未检测到 venv 环境，正在初始化..."
  python3 -m venv venv
fi

# 直接用 venv 里的 python，不依赖 source activate
VENV_PYTHON="venv/bin/python"

# 自动装依赖（只在该装的时候）
if ! $VENV_PYTHON -c "import flask" 2>/dev/null; then
  echo "正在安装依赖..."
  $VENV_PYTHON -m pip install -q flask openpyxl
fi

echo "=================================================="
echo "  魔导书 v2 - AI绘画提示词组合器"
echo "  正在启动..."
echo "=================================================="

# 1.5秒后自动打开浏览器
(sleep 1.5 && xdg-open "http://127.0.0.1:5801") &

$VENV_PYTHON server.py
