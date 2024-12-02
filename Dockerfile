FROM ubuntu:22.04

WORKDIR /app
COPY . /app

RUN apt update
RUN ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN apt install curl clang perl build-essential libc6:amd64 libstdc++6:amd64 libbz2-1.0:amd64 libncurses6:amd64 libncurses-dev openjdk-17-jdk cmake ninja-build pkg-config libgtk-3-dev apt-utils wget git unzip xz-utils zip libglu1-mesa libssl-dev ca-certificates -y

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN . "$HOME/.cargo/env" && cargo install dioxus-cli --version 0.6.0-alpha.5
RUN . "$HOME/.cargo/env" && rustup target add wasm32-unknown-unknown

