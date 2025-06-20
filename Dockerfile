FROM nginx

# Set metadata
LABEL maintainer="yourname@example.com" \
      app="nginx-demo" \
      version="1.0" \
      description="NGINX image with custom homepage, healthcheck, and extra packages for scan testing"

# Inject a custom HTML homepage
RUN echo "<!DOCTYPE html><html><head><title>Welcome</title></head><body><h1>🚀 Hello from a Dockerfile-enhanced NGINX!</h1><p>This is a demo build for CI/CD and scanning.</p></body></html>" \
    > /usr/share/nginx/html/index.html

# Add a custom 404 page
RUN echo "<!DOCTYPE html><html><head><title>404</title></head><body><h2>Custom 404 Page</h2></body></html>" \
    > /usr/share/nginx/html/404.html

# Install extra packages to ensure scan output is meaningful
# These packages are safe but will show in scan results
RUN apt-get update && apt-get install -y \
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
