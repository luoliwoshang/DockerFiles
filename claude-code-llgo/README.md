# Claude Code + llgo Development Environment

基于 `anthropic/claude-code:latest` 的 llgo 开发环境镜像

## 镜像信息

- **基础镜像**: anthropic/claude-code:latest (Debian 12 bookworm, ARM64)
- **Go 版本**: 1.24.2
- **llgo 版本**: v0.11.8
- **LLVM 版本**: 19

## 构建镜像

```bash
cd /Users/zhangzhiyang/Documents/Code/DockerFiles/claude-code-llgo
docker build -t claude-code-llgo:latest .
```

## 运行容器

```bash
# 运行交互式容器（保留 Claude Code 配置）
docker run -it --user root \
  -v "$HOME/.claude-linux:/root/.claude" \
  claude-code-llgo:latest bash

# 挂载 Codex 认证文件（auth.json）
docker run -it --user root \
  -v /Users/zhangzhiyang/.codex/auth.json:/root/.codex/auth.json:ro \
  claude-code-llgo:latest bash

# 挂载 GitHub SSH 与 gitconfig（用于 git push）
docker run -it --user root \
  -v /Users/zhangzhiyang/.ssh:/root/.ssh:ro \
  -v /Users/zhangzhiyang/.gitconfig:/root/.gitconfig:ro \
  claude-code-llgo:latest bash

# 一次性挂载 Codex + GitHub 认证
docker run -it --user root \
  -v /Users/zhangzhiyang/.codex/auth.json:/root/.codex/auth.json:ro \
  -v /Users/zhangzhiyang/.ssh:/root/.ssh:ro \
  -v /Users/zhangzhiyang/.gitconfig:/root/.gitconfig:ro \
  claude-code-llgo:latest bash

# 或者映射工作目录
docker run -it --user root \
  -v "$HOME/.claude-linux:/root/.claude" \
  -v "$PWD:/workspace" \
  -w /workspace \
  claude-code-llgo:latest bash
```

## 验证安装

进入容器后执行：

```bash
# 检查 Go
go version

# 检查 llgo
llgo version

# 检查 LLVM
clang-19 --version

# 检查 Claude Code
claude --version
```

## 已安装的工具

- Claude Code v1.0.65
- Go 1.24.2
- llgo v0.11.8
- LLVM 19 工具链（clang-19, lld-19）
- Node.js v24.4.1
- Python 3.11.2
- 各种开发库（libgc, libssl, zlib, cjson, sqlite3, libuv）

## 注意事项

1. 镜像大小较大，因为包含完整的 LLVM 工具链
2. 默认使用 ARM64 架构（适配 Apple Silicon）
3. llgo 仓库克隆在 `/opt/llgo`
