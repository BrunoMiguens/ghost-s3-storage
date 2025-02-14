# Dockerfile
FROM ghost:5-alpine

# Install git
RUN apk add --no-cache git

# Set working directory
WORKDIR /var/lib/ghost

# Create directories and set permissions
RUN mkdir -p /var/lib/ghost/content/adapters/storage/ghost-minio && \
    chown -R node:node /var/lib/ghost/content

# Switch to node user for installation
USER node

# Install ghost-minio adapter in the correct location
RUN cd /var/lib/ghost/content/adapters/storage/ghost-minio && \
    npm install ghost-minio@github:captbrogers/ghost-minio

# Copy config file
COPY config.production.json /var/lib/ghost/config.production.json

# Ensure the correct ownership of files
RUN chown -R node:node /var/lib/ghost/content

# Start Ghost
CMD ["node", "current/index.js"]