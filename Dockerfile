FROM ubuntu:22.04

LABEL maintainer="Trufi Association"
LABEL description="Extract PBF regions from OpenStreetMap data using osmium-tool"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        osmium-tool \
        wget \
        unzip \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN wget -q https://osmdata.openstreetmap.de/download/water-polygons-split-4326.zip && \
    unzip water-polygons-split-4326.zip && \
    mv water-polygons-split-4326 coastline && \
    rm water-polygons-split-4326.zip

COPY ./run.sh ./run.sh
RUN chmod +x ./run.sh

ENTRYPOINT ["bash", "./run.sh"]
