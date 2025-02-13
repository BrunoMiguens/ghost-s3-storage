# Use the official Ghost image as the base
FROM ghost:latest

# Set working directory
WORKDIR /var/lib/ghost

# Install captbrogers/ghost-minio (S3-compatible storage adapter)
RUN npm install captbrogers/ghost-minio --save
RUN mkdir -p content/adapters/storage
RUN cp -r node_modules/ghost-storage-adapter-s3 content/adapters/storage/s3

# Ensure proper permissions
RUN chown -R node:node /var/lib/ghost

# Expose Ghost's default port
EXPOSE 2368

# Start Ghost
CMD ["docker-entrypoint.sh"]