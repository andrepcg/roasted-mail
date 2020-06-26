FROM ruby:2.6.5-alpine

# Add basic packages
RUN apk add --no-cache \
      build-base \
      postgresql-dev \
      git \
      nodejs \
      yarn \
      tzdata \
      file \
      dcron \
      postgresql-client \
      bash

WORKDIR /app

# Install standard Node modules
COPY package.json yarn.lock /app/
RUN yarn install --frozen-lockfile

# Install standard gems
COPY Gemfile* /app/
RUN gem install bundler:2.1.4 && \
    bundle config --local without 'development test' && \
    bundle install -j4 --retry 3 && \
    # Remove unneeded gems
    bundle clean --force && \
    # Remove unneeded files from installed gems (cached *.gem, *.o, *.c)
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

# Copy the whole application folder into the image
COPY . /app

# Compile assets with Webpacker or Sprockets
#
# Notes:
#   1. Executing "assets:precompile" runs "yarn:install" prior
#   2. Executing "assets:precompile" runs "webpacker:compile", too
#   3. For an app using encrypted credentials, Rails raises a `MissingKeyError`
#      if the master key is missing. Because on CI there is no master key,
#      we hide the credentials while compiling assets (by renaming them before and after)
#
RUN RAILS_ENV=production \
    SECRET_KEY_BASE=dummy \
    bundle exec rails assets:precompile \
    && bundle exec whenever --update-crontab

# Remove folders not needed in resulting image
RUN rm -rf node_modules tmp/cache vendor/bundle test spec

ENV RAILS_LOG_TO_STDOUT true

# Expose Puma port
EXPOSE 3000
