# Make sure it matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.4
FROM --platform=linux/arm64 ruby:$RUBY_VERSION

# Install dependencies (PostgreSQL, Node.js, Yarn, etc.)
RUN apt-get update -qq && \
    apt-get install -y build-essential libvips bash bash-completion libffi-dev tzdata postgresql-client nodejs npm yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# Directory to store the app
WORKDIR /rails

# Define environment variables for Rails
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="development" \
    BUNDLE_WITHOUT="test production"

# Install application gems
COPY Gemfile Gemfile.lock ./

# Run bundle install to install gems
RUN bundle install

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile --gemfile app/ lib/

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000

# Default command to run when container starts
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]