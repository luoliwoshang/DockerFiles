FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "deb http://mirrors.ustc.edu.cn/ubuntu-ports/ focal main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/ubuntu-ports/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt-get clean

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

RUN apt-get update && \
    apt-get install -y llvm-dev clang libclang-dev lld pkg-config libgc-dev libssl-dev zlib1g-dev libffi-dev libcjson-dev libuv1-dev python3.8-dev libsqlite3-dev

RUN apt-get install -y python3-dev

RUN wget https://go.dev/dl/go1.24.2.linux-arm64.tar.gz -O /tmp/go1.24.2.linux-arm64.tar.gz

RUN tar -C /usr/local -xzf /tmp/go1.24.2.linux-arm64.tar.gz
ENV GOROOT=/usr/local/go

ENV PATH="/root/go/bin:/usr/local/go/bin:${PATH}"

ENV CGO_ENABLED=1

RUN git clone https://github.com/goplus/llgo.git ~/llgo && \
    cd ~/llgo && \
    git checkout e68355d94f9f9ec17caae6e0d397bd55f8c5ec33

ENV LLGO_ROOT=/root/llgo

CMD ["/bin/bash"]
