# Stage 1: Download and extract the release
FROM alpine:latest AS downloader

# Argument for the release URL
ARG RELEASE_URL

# Install required tools
RUN apk add --no-cache curl unzip

# Create a directory for the release
WORKDIR /release

# Download and extract the release
RUN curl -L $RELEASE_URL -o release.zip && \
    unzip release.zip

# Stage 2: Build the NGINX container
FROM bitnami/nginx:latest

USER 0

# Copy the two files from the release
RUN mkdir -p /app/lq1
COPY --from=downloader /release/full/id1/pak0.pak /app/lq1/
COPY --from=downloader /release/full/id1/pak1.pak /app/lq1/

COPY index.html /app/
COPY ftewebgl.js /app/
COPY ftewebgl.wasm /app/
COPY default.fmf /app/

USER 1001
