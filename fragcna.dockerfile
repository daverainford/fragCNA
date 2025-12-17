FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    gzip \
    unzip \
    pigz \
    openjdk-17-jre-headless \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget http://opengene.org/fastp/fastp \
    && chmod +x fastp \
    && mv fastp /usr/local/bin/fastp

RUN curl -s https://get.nextflow.io | bash \
    && mv nextflow /usr/local/bin/nextflow \
    && chmod +x /usr/local/bin/nextflow

WORKDIR /workspace
