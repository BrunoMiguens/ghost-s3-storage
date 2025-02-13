# Use the official Ghost image as the base
FROM ghost:latest

# Set working directory
WORKDIR /var/lib/ghost

# Install Git (required for npm to fetch from GitHub)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install captbrogers/ghost-minio (S3-compatible storage adapter)
RUN npm install github:captbrogers/ghost-minio --save
RUN mkdir -p content/adapters/storage
RUN cp -r node_modules/ghost-minio content/adapters/storage/s3

# Copy the custom Ghost configuration file
COPY config.production.json /var/lib/ghost/config.production.json

# Ensure proper permissions
RUN chown -R node:node /var/lib/ghost

# Expose Ghost's default port
EXPOSE 2368

# Start Ghost
CMD ["docker-entrypoint.sh"]