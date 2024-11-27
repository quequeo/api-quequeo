# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 3.2.4

* System dependencies

* Configuration

* Database creation: 

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# api-wellio-fit

* DOCKER - SETUP & COMMANDS
docker-compose build
docker-compose run

# Install gems for docker
docker-compose run app bundle install

# Steps if your add a new gem
docker-compose run app bundle install

# Check if the gem is installed
docker-compose run app bundle list | grep 'new_gem'

# How to install gems like rspec
docker-compose run app rails generate rspec:install

# Run the tests
docker-compose run app rspec
 
