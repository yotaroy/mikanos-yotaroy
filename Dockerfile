FROM ubuntu:18.04

# dosfstoolsにはmkfs.fatが含まれる
RUN apt-get update && apt-get install -y \
  dosfstools \
  git \
  ansible \
  okteta \
  vim

WORKDIR /workspace

RUN git clone https://github.com/uchan-nos/mikanos-build.git osbook

WORKDIR /workspace/osbook/devenv
ENV HOME=/workspace

# 開発ツールの導入
RUN ansible-playbook -K -i ansible_inventory ansible_provision.yml && \
  make -C $HOME/edk2/BaseTools/Source/C

# 標準ライブラリの入手
RUN wget https://github.com/uchan-nos/mikanos-build/releases/download/v2.0/x86_64-elf.tar.gz && \
  tar xf x86_64-elf.tar.gz

WORKDIR /workspace/mikanos

# uchan-nos/mikanos-build.git 内で使用される sudo コマンドに対応するために、何もしない sudo コマンドを用意
COPY dev/sudo /usr/local/bin/sudo
