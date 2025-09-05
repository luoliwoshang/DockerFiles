# Ubuntu 20.04 LLGO Docker 构建修复记录

## 问题背景

在构建基于 Ubuntu 20.04 的 LLGO 开发环境 Docker 镜像时遇到多个问题：

1. **ARM64 架构包源问题**: 原始 Dockerfile 尝试使用不支持 ARM64 的镜像源
2. **Python 版本不匹配**: 指定了 Ubuntu 20.04 中不存在的 `python3.12-dev`
3. **LLVM 仓库连接问题**: apt.llvm.org 出现 502 Bad Gateway 错误

## 解决方案

### 1. 修复 ARM64 包源 (Dockerfile:5-6)

```dockerfile
# 原问题: archive.ubuntu.com 不支持 ARM64，需要使用 ports.ubuntu.com
# 修复: 使用 USTC 镜像的 ubuntu-ports 源
RUN echo "deb http://mirrors.ustc.edu.cn/ubuntu-ports/ focal main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu-ports/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list
```

### 2. 修复 Python 版本 (Dockerfile:22)

```dockerfile
# 原问题: python3.12-dev 在 Ubuntu 20.04 中不存在
# 修复: 使用 Ubuntu 20.04 默认的 python3.8-dev
python3.8-dev
```

### 3. 修复 LLVM 依赖 (Dockerfile:21-22)

```dockerfile
# 原问题: apt.llvm.org LLVM 19 仓库连接不稳定
# 修复: 使用 Ubuntu 官方仓库中的稳定 LLVM 版本
RUN apt-get update && \
    apt-get install -y llvm-dev clang libclang-dev lld pkg-config libgc-dev libssl-dev zlib1g-dev libffi-dev libcjson-dev libuv1-dev python3.8-dev libsqlite3-dev
```

### 4. 简化 PATH 环境变量 (Dockerfile:31)

```dockerfile
# 移除 LLVM-19 特定路径
ENV PATH="/root/go/bin:/usr/local/go/bin:${PATH}"
```

## 技术要点

- **ARM64 支持**: 必须使用 `ubuntu-ports` 而非标准 Ubuntu 源
- **镜像源选择**: USTC 镜像对 ARM64 支持良好且连接稳定
- **包版本匹配**: Ubuntu 20.04 (Focal) 默认 Python 3.8，LLVM 10
- **非交互式安装**: 使用 `ENV DEBIAN_FRONTEND=noninteractive` 避免安装过程中的交互提示

## 构建命令

```bash
docker build -t ubuntu20-llgo-fixed .
```

## 验证

构建成功后包含以下组件：
- Ubuntu 20.04 基础系统
- LLVM/Clang 开发环境  
- Go 1.24.2 (ARM64)
- LLGO 编译器源码
- Python 3.8 开发环境
- 必要的系统工具和库