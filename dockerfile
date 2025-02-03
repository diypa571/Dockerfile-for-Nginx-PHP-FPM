# Diyar Parwana
# Use a base image with Ubuntu (or Debian)
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    php8.3-fpm \
    php8.3-mysql \
    php-curl \
    software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add Ondrej's PHP PPA
RUN add-apt-repository ppa:ondrej/php -y \
    && apt-get update \
    && apt-get install -y php8.3-fpm php8.3-mysql php-curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy your custom Nginx configuration
COPY nginx-default.conf /etc/nginx/sites-available/default

# Create the web root directory
RUN mkdir -p /var/www/html \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Test Nginx configuration
RUN nginx -t

# Expose port 80 for HTTP
EXPOSE 80

# Start Nginx and PHP-FPM in the foreground
CMD service php8.3-fpm start && nginx -g "daemon off;"
