FROM ubuntu:22.04

LABEL maintainer="Trufi Association"
LABEL description="Extract PBF regions from OpenStreetMap data using osmium-tool"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        osmium-tool \
        wget \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY ./run.sh ./run.sh
RUN chmod +x ./run.sh

ENTRYPOINT ["bash", "./run.sh"]
