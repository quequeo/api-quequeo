class Web::QuequeoService < ApplicationService
  def call
    quequeo_content
  end

  private

  def quequeo_content
    {
      es: {
        page_title: 'Sitio Web Quequeo',
        title: 'ReactJS, Ruby on Rails y AWS',
        frontend: 'Este sitio web está desarrollado con React JS y Material-UI. Es parte de mi portafolio personal, diseñado para mostrar información sobre mi experiencia laboral, proyectos personales y habilidades técnicas.',
        backend: 'El backend está construido con una API de Ruby on Rails, utilizando Docker y PostgreSQL como base de datos principal y Redis para optimizar el rendimiento mediante caché.',
        infrastructure: 'La infraestructura está alojada en una instancia EC2 de AWS, usando S3 para almacenar imágenes. Además, el despliegue de la API se realiza automáticamente mediante un pipeline CI/CD configurado con GitHub Actions.'
      },
      en: {
        page_title: 'Quequeo Website',
        title: 'ReactJS, Ruby on Rails & AWS',
        frontend: 'This website is built with React JS and Material-UI. It is part of my personal portfolio, designed to showcase information about my work experience, personal projects, and technical skills.',
        backend: 'The backend of this website is developed using a Ruby on Rails API, with Docker and PostgreSQL as the primary database and Redis for caching to enhance performance.',
        infrastructure: 'The infrastructure is hosted on an AWS EC2 instance, leveraging S3 for secure and efficient storage of images. Additionally, the API deployment is automated using a CI/CD pipeline configured with GitHub Actions.'
      }
    }
  end
end
