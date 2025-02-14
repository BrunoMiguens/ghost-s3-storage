# Dockerfile
FROM ghost:5-alpine

# Set working directory
WORKDIR /var/lib/ghost

# Install ghost-minio adapter in the correct location
RUN mkdir -p /var/lib/ghost/content/adapters/storage/ghost-minio && \
    cd /var/lib/ghost/content/adapters/storage/ghost-minio && \
    npm install ghost-minio@github:captbrogers/ghost-minio

# Set up configuration
COPY config.production.json ./content/config.production.json

# Set permissions
RUN chown -R node:node /var/lib/ghost/content

# Switch to node user
USER node

# Start Ghost
CMD ["node", "current/index.js"]