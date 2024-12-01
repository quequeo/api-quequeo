# API Wellio Fit 🚀

Bienvenido a __API Wellio Fit__, una API desarrollada con __Ruby on Rails 8__ y __Ruby 3.2.4__, diseñada para funcionar dentro de un entorno Dockerizado. 

## Requisitos del Sistema 🛠️

__Ruby: 3.2.4__
__Rails: 8.0.0__
__Docker: 20.10+__
__Docker Compose: 2.x+__

⚙️ **Configuración Inicial** 
1. Clona el repositorio
   ```bash
   git clone https://github.com/tu-usuario/api-wellio-fit.git
   cd api-wellio-fit
2. Construye la imagen de Docker y lanza la aplicación
    ```bash
    docker-compose build
    docker-compose up
****
📦 **Base de Datos**
- La base de datos se crea automáticamente al ejecutar docker-compose build.
****
🧪 **Testing**
1. Configurar RSpec
Si RSpec aún no está configurado:
    ```bash
    docker-compose run app rails generate rspec:install
2. Ejecutar las pruebas
    ```bash
    docker-compose run app bundle exec rspec
****
📋 **Comandos Útiles**
1. Instalar nuevas gemas
Si agregas una nueva gema a tu proyecto, recuerda ejecutarlo dentro del contenedor:
    ```bash
    docker-compose run app bundle install
2. Verificar que la gema está instalada
    ```bash
    docker-compose run app bundle list | grep 'nombre_de_la_gema'
3. Acceder a la consola de Rails del contenedor
    ```bash
    docker-compose run app rails console
4. Acceder a una shell del contenedor
    ```bash
    docker-compose run app sh
****
**Despliegue** 🚢

- El despliegue de esta aplicación en producción sigue estos pasos generales:

...

**Servicios Adicionales** 🔧

...

**CI/CD con GitHub Actions** 🛡️

Pipeline de integración continua de GitHub Actions, asegurando la calidad del código mediante análisis y pruebas automatizadas, que incluye los siguientes pasos:
1. Scan de Seguridad en Ruby: Utiliza bundler-audit y otras herramientas para identificar vulnerabilidades en gemas.
2. Scan de Seguridad en JavaScript: Analiza dependencias de JavaScript utilizando npm audit o herramientas similares.
3. Linting: Asegura que el código sigue las convenciones de estilo con herramientas como rubocop para Ruby y eslint para JavaScript.
4. Pruebas Automatizadas: Ejecuta las pruebas de RSpec para validar la funcionalidad de la aplicación.

**Colaboradores** 👥

Autor: Jaime F. García Méndez

**Licencia** 📜

Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más información.