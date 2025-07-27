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
    libjpeg-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

# create venv
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# install python deps
RUN pip install --no-cache-dir pillow numpy matplotlib \
    && rm -rf /root/.cache /tmp/* \
    && python -c "import PIL" \
    && python -c "from PIL import pillow" \
    && python -c "import numpy" \
    && python -c "import matplotlib"

# install scipy
RUN apt-get install -y \
    gfortran \
    && pip install --no-cache-dir scipy \
    && apt-get remove gfortran \
    && apt-get purge gfortran \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /root/.cache /tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && python -c "import scipy"

# install opencv
RUN pip install --no-cache-dir opencv-python \
    && python -c "import cv2"