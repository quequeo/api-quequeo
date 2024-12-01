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
        nodejs \
        postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# Install rspec globally
RUN gem install rspec

# Directory to store the app
WORKDIR /app

# Copy entrypoint script and make it executable
COPY bin/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Use the entrypoint script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000

# Default command to run when container starts
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
