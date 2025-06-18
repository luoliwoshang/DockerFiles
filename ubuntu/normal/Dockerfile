FROM ubuntu:24.04

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list

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

RUN echo "deb http://apt.llvm.org/$(lsb_release -cs)/ llvm-toolchain-$(lsb_release -cs)-19 main" | sudo tee /etc/apt/sources.list.d/llvm.list
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -

RUN apt-get update && \
    apt-get install -y llvm-19-dev clang-19 libclang-19-dev lld-19 pkg-config libgc-dev libssl-dev zlib1g-dev libffi-dev libcjson-dev libunwind-19-dev libuv1-dev libc++-19-dev python3.12-dev libsqlite3-dev libcjson-dev

RUN apt-get install -y python3-dev

RUN wget https://go.dev/dl/go1.24.2.linux-arm64.tar.gz -O /tmp/go1.24.2.linux-arm64.tar.gz

RUN tar -C /usr/local -xzf /tmp/go1.24.2.linux-arm64.tar.gz
ENV GOROOT=/usr/local/go

ENV PATH="/root/go/bin:/usr/local/go/bin:/usr/lib/llvm-19/bin:/${PATH}"

ENV CGO_ENABLED=1

RUN git clone https://github.com/goplus/llgo.git ~/llgo && \
    cd ~/llgo && \
    git checkout e68355d94f9f9ec17caae6e0d397bd55f8c5ec33
    
ENV LLGO_ROOT=/root/llgo

CMD ["/bin/bash"]
