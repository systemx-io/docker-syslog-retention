# Simple container used to execute cron jobs.
# --
#

FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/systemx-io/docker-syslog-retention
LABEL org.opencontainers.image.licenses=BSD-2-Clause

ADD ./files/purge-syslog /etc/periodic/daily/purge-syslog

CMD ["crond", "-f", "-d", "6"]

# EOF
