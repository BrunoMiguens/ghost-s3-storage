# Dockerfile
FROM ghost:5-alpine

# Install git and build dependencies
RUN apk add --no-cache git python3 make g++ 

# Install ghost-minio adapter
RUN mkdir -p ./content/adapters/storage/ghost-minio && \
    cd ./content/adapters/storage && \
    git clone https://github.com/captbrogers/ghost-minio.git ghost-minio && \
    cd ghost-minio && \
    npm install --production

# Set up configuration
COPY config.production.json ./content/config.production.json

# Set permissions
RUN chown -R node:node /var/lib/ghost/content

# Switch to node user
USER node

# Start Ghost
CMD ["node", "current/index.js"]