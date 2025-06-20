FROM nginx

LABEL maintainer="yourname@example.com" \
      app="nginx-demo" \
      version="1.0" \
      description="NGINX image with custom homepage, healthcheck, and extra packages for scan testing"

# Inject custom homepage
RUN echo "<!DOCTYPE html><html><head><title>Welcome</title></head><body><h1>🚀 Hello from a Dockerfile-enhanced NGINX!</h1><p>This is a demo build for CI/CD and scanning.</p></body></html>" \
    > /usr/share/nginx/html/index.html

# Custom 404 page
RUN echo "<!DOCTYPE html><html><head><title>404</title></head><body><h2>Custom 404 Page</h2></body></html>" \
    > /usr/share/nginx/html/404.html

# Install additional packages (fixes included)
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      apt-utils \
      curl \
      wget \
      netcat \
      unzip \
      gnupg \
      vim \
 && rm -rf /var/lib/apt/lists/*

# Add Docker-native healthcheck
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
