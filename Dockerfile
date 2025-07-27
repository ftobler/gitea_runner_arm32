FROM ubuntu:latest

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && \
    apt-get install -y \
    python3 python3-pip python3-venv \
    nodejs npm \
    build-essential \
    git curl \
    libffi-dev pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

# create venv
RUN python3 -m venv /.venv
ENV PATH="/opt/venv/bin:$PATH"

# install python deps
RUN pip install --no-cache-dir numpy matplotlib \
    && rm -rf /tmp/*

# scipy requires apt install gfortan