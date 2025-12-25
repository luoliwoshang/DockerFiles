#!/bin/bash
# Claude Code + llgo Docker 镜像构建脚本
# 用途：自动化构建 claude-code-llgo 镜像并提供使用提示

# 遇到任何错误立即退出
set -e

echo "🔨 Building Claude Code + llgo Docker image..."

# ============================================================
# 架构检查
# ============================================================
# 检测当前系统架构
ARCH=$(uname -m)

# 该镜像针对 ARM64 架构优化（Apple Silicon Mac）
# 如果在其他架构上构建可能需要较长时间或失败
if [ "$ARCH" != "arm64" ] && [ "$ARCH" != "aarch64" ]; then
    echo "⚠️  Warning: This build script is optimized for ARM64 architecture."
    echo "   Current architecture: $ARCH"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    # 如果用户不确认，则退出
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# ============================================================
# 构建 Docker 镜像
# ============================================================
# 使用当前目录的 Dockerfile 构建镜像
# 标签名：claude-code-llgo:latest
docker build -t claude-code-llgo:latest .

# ============================================================
# 构建成功提示
# ============================================================
echo "✅ Build complete!"
echo ""
echo "🚀 Run the container with:"
echo "   docker run -it --user root -v \"\$HOME/.claude-linux:/root/.claude\" claude-code-llgo:latest bash"
