# Simple container used to execute cron jobs.
# --
#

LABEL org.opencontainers.image.source https://github.com/systemx-io/docker-syslog-retention

FROM alpine:latest

ADD ./files/purge-syslog /etc/periodic/daily/purge-syslog

CMD ["crond", "-f", "-l", "2"]

# EOF
