# API Wellio Fit 🚀

Bienvenido a __API Wellio Fit__, una API desarrollada con __Ruby on Rails 8__ y __Ruby 3.2.4__, diseñada para funcionar dentro de un entorno Dockerizado. 
Este README detalla cómo configurar, ejecutar y probar la aplicación.

## Requisitos del Sistema 🛠️

__Ruby: 3.2.4__
__Rails: 8.0.0__
__Docker: 20.10+__
__Docker Compose: 2.x+__

### Configuración Inicial ⚙️
1. **Clona el repositorio**
   ```bash
   git clone https://github.com/tu-usuario/api-wellio-fit.git
   cd api-wellio-fit
2. **Construye la imagen de Docker**
    ```bash
    docker-compose build
3. **Instala las gemas necesarias**
    ```bash
    docker-compose run app bundle install
4. **Configura las variables de entorno**
Crea un archivo .env en el directorio raíz con los siguientes valores:
    ```makefile
    RAILS_ENV=development
    DATABASE_URL=postgres://user:password@db:5432/api_wellio_fit
    SECRET_KEY_BASE=tu_clave_secreta
****
**Base de Datos** 📦
1. Crear la base de datos
    ```bash
    docker-compose run app rails db:create
2. Ejecutar migraciones
    ```bash
    docker-compose run app rails db:migrate
3. (Opcional) Cargar datos iniciales
Si tienes un archivo db/seeds.rb, puedes ejecutarlo con:
    ```bash
    docker-compose run app rails db:seed
****
**Testing** 🧪
1. Configurar RSpec
Si RSpec aún no está configurado:
    ```bash
    docker-compose run app rails generate rspec:install
2. Ejecutar las pruebas
    ```bash
    docker-compose run app rspec
****
**Comandos Útiles** 📋 
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
El despliegue de esta aplicación en producción sigue estos pasos generales:

...

**Servicios Adicionales** 🔧

...

**Colaboradores** 👥
Autor: Jaime F. García Méndez

**Licencia** 📜
Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más información.