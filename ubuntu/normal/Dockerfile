FROM ubuntu:latest

run sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
run sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
run apt-get clean

RUN apt-get update && apt-get install -y vim && apt-get install -y gnupg2

CMD ["/bin/bash"]
