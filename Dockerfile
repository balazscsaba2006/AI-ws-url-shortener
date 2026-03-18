FROM php:8.5-cli

# System deps
RUN apt-get update && apt-get install -y \
    unzip git curl sqlite3 libsqlite3-dev libzip-dev libonig-dev \
    && docker-php-ext-install pdo_sqlite zip mbstring pcntl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

WORKDIR /app
COPY . .

RUN composer install --no-interaction --prefer-dist \
    && bun install \
    && bun add -g concurrently

EXPOSE 8000 5173

CMD ["php", "artisan", "serve", "--host=0.0.0.0"]
