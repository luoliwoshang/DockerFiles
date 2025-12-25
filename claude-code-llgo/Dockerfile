# Claude Code + llgo 开发环境
# 基于 Anthropic 官方 Claude Code 镜像 (Debian 12 bookworm ARM64)
# 集成 llgo v0.11.8 + Go 1.24.2 + LLVM 19 工具链
FROM anthropic/claude-code:latest

# 切换到 root 用户进行软件安装
# Claude Code 基础镜像默认用户是 codeagent，需要切换到 root 才有安装权限
USER root

# ============================================================
# 环境变量配置
# ============================================================
# 非交互式安装，避免 apt-get 安装时等待用户输入
ENV DEBIAN_FRONTEND=noninteractive
# Go 版本：1.24.2
ENV GO_VERSION=1.24.2
# llgo 版本：v0.11.8 (稳定版)
ENV LLGO_VERSION=v0.11.8

# ============================================================
# 安装基础开发工具
# ============================================================
# vim:        文本编辑器
# gnupg2:     GPG 加密工具，用于验证软件包签名
# git:        版本控制系统
# sudo:       权限管理工具
# wget:       下载工具
# pkg-config: 编译配置工具
# gcc/g++:    C/C++ 编译器
# lsb-release: Linux 发行版信息查询工具
RUN apt-get update && \
    apt-get install -y vim && \
    apt-get install -y gnupg2 && \
    apt-get install -y git && \
    apt-get install -y sudo && \
    apt-get install -y wget && \
    apt-get install -y pkg-config && \
    apt-get install -y gcc && \
    apt-get install -y g++ && \
    apt-get install -y lsb-release

# ============================================================
# 配置 LLVM 19 软件源
# ============================================================
# 添加 LLVM 官方 APT 源（针对 Debian 12 bookworm）
RUN echo "deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-19 main" | sudo tee /etc/apt/sources.list.d/llvm.list
# 导入 LLVM GPG 密钥，用于验证软件包签名
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

# ============================================================
# 安装 LLVM 19 工具链和依赖库
# ============================================================
# LLVM 工具链:
#   llvm-19-dev:      LLVM 开发库
#   clang-19:         C/C++ 编译器前端
#   libclang-19-dev:  Clang 开发库
#   lld-19:           LLVM 链接器
#   libunwind-19-dev: 栈展开库（异常处理）
#   libc++-19-dev:    LLVM C++ 标准库
#
# llgo 依赖库:
#   libgc-dev:        垃圾回收库（Boehm GC）
#   libssl-dev:       SSL/TLS 加密库
#   zlib1g-dev:       压缩库
#   libffi-dev:       外部函数接口库
#   libcjson-dev:     JSON 解析库
#   libuv1-dev:       异步 I/O 库
#   libsqlite3-dev:   SQLite 数据库库
RUN apt-get update && \
    apt-get install -y llvm-19-dev clang-19 libclang-19-dev lld-19 libunwind-19-dev libc++-19-dev && \
    apt-get install -y libgc-dev libssl-dev zlib1g-dev libffi-dev libcjson-dev libuv1-dev libsqlite3-dev

# ============================================================
# 安装 Python 开发包（可选）
# ============================================================
# 用于需要 Python 绑定的 llgo 扩展功能
RUN apt-get install -y python3-dev

# ============================================================
# 安装 Go 1.24.2
# ============================================================
# 下载 Go 1.24.2 for Linux ARM64
# 解压到 /usr/local/go
# 清理临时文件
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-arm64.tar.gz -O /tmp/go${GO_VERSION}.linux-arm64.tar.gz && \
    tar -C /usr/local -xzf /tmp/go${GO_VERSION}.linux-arm64.tar.gz && \
    rm /tmp/go${GO_VERSION}.linux-arm64.tar.gz

# ============================================================
# 配置 Go 环境变量
# ============================================================
# GOROOT:      Go 安装路径
# PATH:        添加 Go bin、GOPATH bin、LLVM bin 到系统路径
# CGO_ENABLED: 启用 CGO，允许 Go 调用 C 代码（llgo 需要）
ENV GOROOT=/usr/local/go
ENV PATH="/root/go/bin:/usr/local/go/bin:/usr/lib/llvm-19/bin:${PATH}"
ENV CGO_ENABLED=1

# ============================================================
# 安装 llgo v0.11.8
# ============================================================
# 从 GitHub 克隆 llgo 仓库到 ~/llgo
# 切换到指定版本标签 v0.11.8
RUN git clone https://github.com/goplus/llgo.git ~/llgo && \
    cd ~/llgo && \
    git checkout ${LLGO_VERSION}

# 设置 llgo 根目录环境变量
ENV LLGO_ROOT=/root/llgo

# 运行 llgo 官方安装脚本
# 该脚本会编译并安装 llgo 到系统路径
RUN cd ~/llgo && chmod +x install.sh && ./install.sh

# ============================================================
# 验证安装
# ============================================================
# 构建时验证 Go 和 llgo 是否正确安装
RUN go version && llgo version

# 设置默认工作目录
WORKDIR /root

# 容器启动时默认进入 bash shell
CMD ["/bin/bash"]
