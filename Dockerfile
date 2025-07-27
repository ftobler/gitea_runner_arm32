FROM ubuntu:latest

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install everything in one go
RUN apt-get update && \
    apt-get install -y \
    python3 python3-pip python3-venv \
    nodejs npm \
    build-essential \
    git curl \
    libffi-dev pkg-config \
#  && python3 -m venv /.venv \
    && pip install --no-cache-dir numpy matplotlib \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && RUN rm -rf /tmp/pip-*

# scipy requires apt install gfortan