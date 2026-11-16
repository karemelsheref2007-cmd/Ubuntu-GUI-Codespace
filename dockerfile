FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-terminal \
    thunar \
    mousepad \
    tigervnc-standalone-server \
    tigervnc-tools \
    novnc \
    websockify \
    dbus-x11 \
    firefox \
    epiphany-browser \
    sudo \
    curl \
    wget \
    git \
    nano \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER vscode

WORKDIR /home/vscode

RUN mkdir -p /home/vscode/.vnc

COPY start.sh /usr/local/bin/start.sh

USER root

RUN chmod +x /usr/local/bin/start.sh

USER vscode

EXPOSE 5901 6080

CMD ["/usr/local/bin/start.sh"]
