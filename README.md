# docker-syslog-retention
The provided container implements a simple cron-job that removes log files older than 90 days.

Supported architectures:
* `linux/amd64`
* `linux/arm64`

## Usage
This container needs to mount the volume used by the `syslog-collector` in read/write mode. This implies that you need to run this container in the same pod as the `syslog-collector` in Kubernetes.

The container runs `crond` as non-root and removes logfiles older than 90 days using a simple cron job.
Default cron-job: `/usr/bin/find /app/data/syslog -type f -mtime +90 -delete`

## How to build
Bulding the image locally using Docker Desktop on my M-series MacBook:

`docker buildx build --platform linux/amd64,linux/arm64 --tag ghcr.io/systemx-io/syslog-retention:x.y.z --push .`
