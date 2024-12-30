class Web::AboutMeService < ApplicationService
  def call
    about_me_content
  end

  private

  def about_me_content
    total_years = Time.zone.now.year - 2017
    {
      es: {
        page_title: 'Sobre mí',
        title: 'Jaime García Méndez',
        about: "Soy un desarrollador de software con #{total_years} años de experiencia, especializado en Ruby y Ruby on Rails, pero también con conocimientos de React, Heroku, Docker y AWS.",
        experience: 'Mi trabajo diario incluye el uso de herramientas como Sidekiq, Redis, AWS, Bugsnag, Git, Jira, Docker, RESTful APIs, Postgres, SQL, RSpec, etc. Implemento nuevas funciones, resuelvo problemas y hago troubleshooting.',
        more: 'Fuera del trabajo, tengo una familia increíble con dos hijos, y disfruto jugar al fútbol, al pádel y entrenar.'
      },
      en: {
        page_title: 'About me',
        title: 'Jaime García Méndez',
        about: "I am a software developer with #{total_years} years of experience, specialized in Ruby and Ruby on Rails, but also skilled in JavaScript, React JS, Heroku, Docker, and AWS.",
        experience: 'My daily work includes using tools like Sidekiq, Redis, AWS (Athena, EC2, SNS, SQS), Bugsnag, Git, Jira, Docker, RESTful APIs, Postgres, RSpec, etc. I implement new features, solve problems, and do troubleshooting.',
        more: 'Outside of work, I have an amazing family with two children, and I enjoy playing football, paddle, and training.'
      }
    }
  end
end
