# Simple container used to execute a cron-job that implements data retention.
# --
#

FROM --platform=$BUILDPLATFORM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/systemx-io/docker-syslog-retention
LABEL org.opencontainers.image.licenses=BSD-2-Clause

RUN addgroup -g 9999 syslog && \
        adduser -u 9999 -h /var/empty -g "syslog sandbox" -s /sbin/nologin -G syslog -D -H syslog

RUN install -d -D -o root -g syslog -m 0750 /etc/cron.d

# grant CAP_SETGID to busybox so that non-root crond works
RUN apk add --no-cache libcap && \
	setcap cap_setgid=ep /bin/busybox

ADD --chown=root:root --chmod=755 ./files/entrypoint.sh /entrypoint.sh
ADD --chown=syslog:syslog --chmod=640 ./files/purge-syslog /etc/cron.d/syslog

USER syslog

ENTRYPOINT ["/entrypoint.sh"]
CMD ["crond", "-f", "-d", "6", "-c", "/etc/cron.d"]

# EOF
