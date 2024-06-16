FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y vim && \
    apt-get install -y gnupg2 && \
    apt-get install -y git && \
    apt-get install -y sudo && \
    apt-get install -y wget && \
    apt-get install -y pkg-config && \
    apt-get install -y gcc && \
    apt-get install -y g++

# 原始的软件源
# RUN echo 'deb http://apt.llvm.org/focal/ llvm-toolchain-focal-17 main' | sudo tee /etc/apt/sources.list.d/llvm.list
# RUN wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

# bullseye的软件源
RUN echo 'deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-17 main' | sudo tee /etc/apt/sources.list.d/llvm.list
RUN wget -qO - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

RUN apt-get update && \
    apt-get install -y libgc-dev && \
    apt-get install -y --no-install-recommends llvm-17-dev && \
    apt-get install -y clang-17 && \
    apt-get install -y libcjson-dev

RUN wget https://go.dev/dl/go1.20.14.linux-arm64.tar.gz -O /tmp/go1.20.14.linux-arm64.tar.gz

RUN tar -C /usr/local -xzf /tmp/go1.20.14.linux-arm64.tar.gz
ENV GOROOT=/usr/local/go

ENV PATH="/root/go/bin:/usr/local/go/bin:/usr/lib/llvm-17/bin:/${PATH}"

ENV CGO_ENABLED=1

RUN git clone https://github.com/goplus/llgo.git ~/llgo
ENV LLGOROOT=/root/llgo

CMD ["/bin/bash"]