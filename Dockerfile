FROM ruby:3.2.4-slim-bullseye

# Configure working environment
ENV BUNDLE_PATH=/gems \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    RAILS_ENV=development \
    BUNDLE_WITHOUT=production

# Install dependencies (PostgreSQL, Node.js, Yarn, etc.)
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# Directory to store the app
WORKDIR /app

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'production test' && bundle install

# Copy application code
COPY . .

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000

# Default command to run when container starts
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
