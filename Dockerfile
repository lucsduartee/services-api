# alex docker file

# FROM ruby:3.1.2-alpine3.15 AS base

# ENV LANG en_US.UTF-8
# ENV LANGUAGE en_US.UTF-8
# ENV LC_ALL en_US.UTF-8

# WORKDIR /home/services-api

# RUN apk add --update --no-cache \
    # build-base \
    # bash \
    # postgresql-client \
    # cmake \
    # curl \
    # less \
    # vim \
    # libssl1.1 \
    # postgresql-dev

# COPY . .

# EXPOSE 3000

# RUN bundle install

# FROM base AS deploy

# ARG RAILS_ENV
# ARG RAILS_MASTER_KEY

# RUN bundle config --global frozen 1
# RUN bundle config set --global without "development test"
# RUN bundle install --jobs $(nproc --ignore=1) --retry 5
# RUN bundle exec bootsnap precompile --gemfile app/

# CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]

# syntax=docker/dockerfile:1
# FROM ruby:3.1.1
# RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# WORKDIR /services-api
# COPY Gemfile /services-api/Gemfile
# COPY Gemfile.lock /services-api/Gemfile.lock
# COPY . .
# RUN bundle install

# # Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

# syntax = docker/dockerfile:1

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t my-app .
# docker run -d -p 80:80 -p 443:443 --name my-app -e RAILS_MASTER_KEY=<value from config/master.key> my-app
# 

# docker build -t app .
# docker volume create app-storage
# docker run --rm -it -v app-storage:/rails/storage -p 3000:3000 --env RAILS_MASTER_KEY=e7d51cd971c23e042a4d821dbdb97d83 app

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.1.1
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base
# 
# Rails app lives here
WORKDIR /rails
# 
# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives
# 
# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"
# 
# Throw-away build stage to reduce size of final image
FROM base AS build
# 
# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives
# 
# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile
# 
# Copy application code
COPY . .
# 
# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/
# 
# 
# 
# 
# Final stage for app image
FROM base
# 
# Copy built artifacts: gems, application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails
# 
# Run and own only the runtime files as a non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000
# 
# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
# 
# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
