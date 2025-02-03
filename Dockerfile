# Use a specific version of the base image for stability
FROM nginx:latest

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install additional packages in a single RUN layer to reduce image size
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends tree net-tools iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy source files to the default NGINX HTML directory
COPY index.html /usr/share/nginx/html/

# Set working directory (optional, as NGINX already serves from /usr/share/nginx/html)
WORKDIR /usr/share/nginx/html

# Set custom environment variable
ENV MY_NGINX=DevOpsGuruPro

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]