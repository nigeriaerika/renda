# Dockerfile for Northflank Combined Service

# 1. Start with a lightweight, official Node.js image.
FROM node:18-slim

# 2. Install the node-tcp-proxy package globally.
RUN npm install -g node-tcp-proxy --no-update-notifier

# 3. Define the command that will be run when the container starts.
#    It listens on the internal port Northflank provides via the $PORT environment variable.
#    It forwards all raw TCP traffic to rvn.kryptex.network:7031.
#    The 'while true' loop ensures it restarts if it ever crashes.
CMD ["sh", "-c", "while true; do tcpproxy --hostname 0.0.0.0 --proxyPort ${PORT:-8080} --serviceHost rvn.kryptex.network --servicePort 7031 -q; sleep 3; done"]
