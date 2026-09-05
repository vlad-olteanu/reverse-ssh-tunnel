#!/bin/sh
set -eu

if [ -z "${SSH_PUBLIC_KEY:-}" ]; then
    echo "ERROR: SSH_PUBLIC_KEY is not set"
    exit 1
fi

printf '%s\n' "$SSH_PUBLIC_KEY" > /root/.ssh/authorized_keys

chmod 600 /root/.ssh/authorized_keys
chown root:root /root/.ssh/authorized_keys

# generate host keys at first start if absent (persists across rebuilds when /etc/ssh is a volume)
if [ ! -f /etc/ssh/ssh_host_ed25519_key ]; then
    mkdir -p /etc/ssh
    ssh-keygen -A
fi

exec /usr/sbin/sshd -D -e
