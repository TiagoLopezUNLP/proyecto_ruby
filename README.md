# **Disquería Online**

Descubre nuestra colección de vinilos y CDs. Nuevos y usados, los mejores discos para tu colección.

## Descripción del Proyecto

Este es el Trabajo Final Integrador para la cátedra de **Taller de Tecnologías de Producción de Software - Ruby**.

Se trata de una aplicación web completa para la gestión de inventario de una disquería, desarrollada con **Ruby on Rails 8.1.1** y **Ruby 3.4.0+**.

### Características principales:

- **Storefront público** para visualización de discos (CDs y vinilos)
- **Sistema de administración** con roles de usuario (Administrador, Gerente, Empleado)
- **Gestión completa de productos** (CRUD, stock, imágenes, audio para usados)
- **Registro de ventas presenciales** con generación de PDF
- **Sistema de autenticación**
- **Búsqueda y filtros avanzados**
- **Diseño responsive** con Tailwind CSS

---

## Requisitos Técnicos

### Versiones:

- **Ruby**: 3.4.0 o superior
- **Rails**: 8.1.1
- **Base de datos**: PostgreSQL 16

---

## Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/TiagoLopezUNLP/proyecto_ruby
cd proyecto_ruby
```

### 2. Configurar base de datos PostgreSQL

### En Windows:

1. Descargar e instalar PostgreSQL desde [postgresql.org](https://www.postgresql.org/download/windows/)
2. Durante la instalación, configurar:
    - Usuario: `postgres`
    - Contraseña: `admin`
    - Database: `ejemplo`
    - Puerto: `5432`
3. Verificar que el servicio PostgreSQL esté corriendo en Services

### En Ubuntu/Linux:

```bash
sudo apt update
sudo apt install postgresql postgresql-contrib libpq-dev
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'admin';"
sudo systemctl start postgresql
sudo systemctl enable postgresql

```

### 3. Instalar dependencias

**Asegúrese de que los comandos que se usan a continuación estén en la ruta del proyecto**

### En Windows:

1. Instalar Ruby usando RubyInstaller:
    - Descargar desde [rubyinstaller.org](https://rubyinstaller.org/)
    - Versión: 3.4.0 o superior
    - Marcar "Add Ruby to PATH"
2. Instalar bundler y dependencias:

```bash
gem install bundler
bundle install
rails tailwindcss:install
```

### En Ubuntu/Linux:

```bash
# Instalar RVM para Ruby
sudo apt-get install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
rvm install 3.4.0
rvm use 3.4.0 --default

# Instalar dependencias del sistema
sudo apt-get install libpq-dev build-essential

# Instalar bundler y gems
gem install bundler
bundle install
rails tailwindcss:install

```

### 4. Configurar base de datos

```bash
# Crear y configurar la base de datos
rails db:create
rails db:migrate
rails db:seed

```

### 5. Ejecutar la aplicación

```bash
rails server

# O con puerto específico
rails server -p 3000
```

La aplicación estará disponible en: `http://localhost:3000`

---

### Datos de prueba

El script `db/seeds.rb` incluye:

- Varios productos de ejemplo (vinilos y CDs, nuevos y usados)
- Varias categorías musicales
- Usuarios con diferentes roles
- Ventas de ejemplo

### Usuarios predeterminados (creados por seeds.rb)

- **Administrador**: admin@gmail.com / 123456789
- **Gerente**:  gerente@gmail.com / 123456789
- **Empleado**: empleado@gmail.com / 123456789

---

### Gems principales:

- `devise` - Autenticación de usuarios
- `cancancan` - Autorización por roles
- `ransack` - Búsqueda y filtrado
- `tailwindcss-rails` - Estilos
- `prawn` y `prawn-table` - Generación de PDF
- `will_paginate` - Paginación

---

### Administrador:

- Acceso completo a todas las funcionalidades
- Gestión de usuarios (crear/editar/eliminar)
- Administración de productos y ventas
- Ver todos los reportes

### Gerente:

- Administrar productos y ventas
- Gestionar usuarios (excepto administradores)
- Generar reportes de ventas

### Empleado:

- Listar y registrar ventas
- Gestionar productos (stock, precios)
- Modificar su información personal

### Público (Storefront):

- Ver catálogo de productos
- Buscar y filtrar discos
- Escuchar muestras de audio (discos usados)
- Ver productos relacionados

---

## Características Técnicas Destacadas

### 1. Sistema de Búsqueda

- Filtrado por: título, artista, lanzamiento, tipo, estado, género,etc
- Implementado con Ransack

### 2. Gestión de Imágenes

- Uso de Active Storage
- Validación de formatos y tamaños

### 3. Sistema de Ventas

- Transacciones atómicas (rollback automático si falta stock)
- Generación de PDF con Prawn
- Cancelación lógica de ventas
- Restauración automática de stock al cancelar

### 4. Seguridad

- Autenticación con Devise
- Autorización por roles con CanCanCan

### 5. UI/UX

- Diseño responsive con Tailwind CSS
- Paginación con will_paginate
- Validaciones en tiempo real

---

## Contacto

- **Materia**: Taller de Tecnologías de Producción de Software - Ruby
- **Año**: 2025
- **Integrantes**:
    - https://github.com/TiagoLopezUNLP
    - https://github.com/ivanskrt
    - https://github.com/felipeverdugo1
