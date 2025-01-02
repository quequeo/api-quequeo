# API Quequeo 🚀

Welcome to __API Quequeo__, a robust API developed with __Ruby on Rails 8__ and __Ruby 3.2.4__, designed to operate seamlessly within a Dockerized environment.

## System Requirements 🛠️

__Ruby: 3.2.4__
__Rails: 8.0.0__
__PostgreSQL: 15+__
__Docker: 20.10+__
__Docker Compose: 2.x+__

⚙️ **Initial Setup** 
1. Clone the repository
   ```bash
   git clone https://github.com/your-username/api-quequeo.git
   cd api-quequeo
2. Build and launch the application using Docker Compose:
    ```bash
    docker-compose build
    docker-compose up
****
**Database** 📦 
The database configuration is automated through Docker Compose. Upon running docker-compose build, the PostgreSQL database is initialized using the following environment variables:
- Database Configuration (default):
    - Adapter: PostgreSQL
    - Host: db (via Docker network)
    - Username: Defined by POSTGRES_USER
    - Password: Defined by POSTGRES_PASSWORD
    - Database: api_quequeo_[environment]
****
**Routes** 📚

For a full list of routes, see config/routes.rb
****
**Testing** 🧪 
This projects uses __RSpec__ for testing. Here's how you can run the tests:
1. Install RSpec (if not already configured):
    ```bash
    docker-compose run app rails generate rspec:install
2. Run the test suite:
    ```bash
    docker-compose run app bundle exec rspec
3. Database cleaning: The test environment uses **database_cleaner** for a clean slate between tests.
****
**CI/CD Pipeline** 🛡️
- CI (Continuous Integration)
The CI pipeline is configured using **GitHub** Actions and includes:
    - Ruby Security Scanning: Tools like brakeman to detect vulnerabilities in Rails.
    - Linting: Ensures code quality and style using rubocop.
    - RSpec Testing: executes the test suite.
- CD (Continuous Deployment)
The deployment process uses **GitHub Actions** to deploy to an EC2 instance via SSH. Upon successful completion of the CI pipeline:
    - Pulls the latest code to the EC2 instance.
    - Stops and rebuilds the Docker container.
    - Launches the updated application.
****
**Additional Features** 🔧
- Authentication: Implemented using JWT.
- Authorization: Managed by Pundit for role-based access control.
- File Uploads: Utilizes AWS S3 for storage.
- Serialization: Active Model Serializers for clean JSON responses.
- Monitoring: Scout APM for performance monitoring and error tracking.
***
**Useful Commands** 📋 
1. Install new gems:
    ```bash
    docker-compose run app bundle install
2. Verify if the gem is installed
    ```bash
    docker-compose run app bundle list | grep 'gem_name'
3. Rails console
    ```bash
    docker-compose run app rails console
4. Shell access to the container:
    ```bash
    docker-compose run app sh
****
**Monitoring** 📊
This project uses __Scout APM__ for application performance monitoring and error tracking.
****
**Deployment** 🚢
1. Development: Run locally using Docker Compose:
    ```bash
    docker-compose up
2. Production: 
Ensure all environment variables are set. Use the CI/CD pipeline for deployment.
****
**License** 📜
This project is licensed under the MIT License.

**Author** 👥
Developed by **Jaime F. García Méndez**
