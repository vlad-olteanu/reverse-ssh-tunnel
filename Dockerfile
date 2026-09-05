FROM alpine

RUN apk add --no-cache openssh-server \
    && mkdir -p /run/sshd /root/.ssh \
    && chmod 700 /root/.ssh \
    && chown -R root:root /root/.ssh

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
