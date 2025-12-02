require 'open-uri'

# Limpiar datos existentes (opcional, ten cuidado en producción)
puts "Limpiando base de datos..."
Producto.destroy_all
Categorium.destroy_all
Autor.destroy_all
User.destroy_all

# Crear usuarios
puts "Creando usuarios..."
admin = User.create!(
  email: "admin@gmail.com",
  password: "123456789",
  password_confirmation: "123456789",
  role: "administrador"
)

empleado = User.create!(
  email: "empleado@gmail.com",
  password: "123456789",
  password_confirmation: "123456789",
  role: "empleado"
)

gerente = User.create!(
  email: "gerente@gmail.com",
  password: "123456789",
  password_confirmation: "123456789",
  role: "gerente"
)

cliente = User.create!(
  email: "cliente@gmail.com",
  password: "123456789",
  password_confirmation: "123456789",
  role: "cliente"
)

puts "Usuarios creados: #{User.count}"

# Crear categorías con géneros musicales
puts "Creando categorías (géneros musicales)..."
generos_musicales = [
  "Rock",
  "Pop",
  "Jazz",
  "Blues",
  "Reggae",
  "Hip Hop",
  "Rap",
  "Soul",
  "Funk",
  "Disco",
  "Electronic",
  "House",
  "Techno",
  "Trance",
  "Dubstep",
  "Classical",
  "Opera",
  "Country",
  "Folk",
  "Indie",
  "Alternative",
  "Punk",
  "Metal",
  "Heavy Metal",
  "Reggaeton",
  "Salsa",
  "Merengue",
  "Bachata",
  "Cumbia",
  "Tango",
  "Flamenco",
  "Samba",
  "K-Pop",
]

generos_musicales.each do |genero|
  Categorium.create!(nombre: genero)
end

puts "Categorías creadas: #{Categorium.count}"

# Crear autores/artistas
puts "Creando autores..."
artistas = [
  { nombre: "The Beatles" },
  { nombre: "Michael Jackson" },
  { nombre: "Queen" },
  { nombre: "Bob Marley" },
  { nombre: "Miles Davis" },
  { nombre: "Tupac Shakur" },
  { nombre: "Daft Punk" },
  { nombre: "Bad Bunny" },
  { nombre: "Adele" },
  { nombre: "Eminem" },
  { nombre: "Nirvana" },
  { nombre: "Beyoncé" },
  { nombre: "Elvis Presley" },
  { nombre: "Madonna" },
]

artistas.each do |artista|
  Autor.create!(artista)
end

puts "Autores creados: #{Autor.count}"

# Crear productos de prueba
puts "Creando productos de prueba..."

productos_data = [
  { nombre: "Abbey Road", descripcion: "Álbum icónico de The Beatles lanzado en 1969", precio: 25.99, stock: 15, tipo: "vinilo", estado: "nuevo" },
  { nombre: "Thriller", descripcion: "El álbum más vendido de todos los tiempos de Michael Jackson", precio: 29.99, stock: 20, tipo: "cd", estado: "nuevo" },
  { nombre: "A Night at the Opera", descripcion: "Álbum clásico de Queen con Bohemian Rhapsody", precio: 22.50, stock: 10, tipo: "vinilo", estado: "usado" },
  { nombre: "Legend", descripcion: "La mejor compilación de Bob Marley", precio: 18.99, stock: 25, tipo: "cd", estado: "nuevo" },
  { nombre: "Kind of Blue", descripcion: "Obra maestra del jazz de Miles Davis", precio: 24.99, stock: 8, tipo: "vinilo", estado: "nuevo" },
  { nombre: "All Eyez on Me", descripcion: "Álbum doble de Tupac Shakur", precio: 19.99, stock: 12, tipo: "cd", estado: "usado" },
  { nombre: "Discovery", descripcion: "Segundo álbum de estudio de Daft Punk", precio: 27.99, stock: 18, tipo: "vinilo", estado: "nuevo" },
  { nombre: "Un Verano Sin Ti", descripcion: "Álbum de reggaeton de Bad Bunny", precio: 21.99, stock: 30, tipo: "cd", estado: "nuevo" },
  { nombre: "21", descripcion: "Álbum ganador del Grammy de Adele", precio: 16.99, stock: 22, tipo: "cd", estado: "nuevo" },
  { nombre: "The Eminem Show", descripcion: "Cuarto álbum de estudio de Eminem", precio: 20.99, stock: 14, tipo: "cd", estado: "usado" },
  { nombre: "Nevermind", descripcion: "Álbum revolucionario de Nirvana con Smells Like Teen Spirit", precio: 23.99, stock: 17, tipo: "vinilo", estado: "nuevo" },
  { nombre: "Lemonade", descripcion: "Álbum visual de Beyoncé", precio: 24.99, stock: 19, tipo: "vinilo", estado: "nuevo" },
  { nombre: "Elvis Presley", descripcion: "Álbum debut homónimo del Rey del Rock", precio: 28.99, stock: 7, tipo: "vinilo", estado: "usado" },
  { nombre: "Like a Virgin", descripcion: "Segundo álbum de estudio de Madonna", precio: 17.99, stock: 13, tipo: "cd", estado: "nuevo" },
  { nombre: "The Dark Side of the Moon", descripcion: "Álbum conceptual de Pink Floyd", precio: 26.99, stock: 11, tipo: "vinilo", estado: "nuevo" },
  { nombre: "Back in Black", descripcion: "Álbum de AC/DC dedicado a Bon Scott", precio: 22.99, stock: 16, tipo: "vinilo", estado: "usado" },
  { nombre: "Rumours", descripcion: "Álbum clásico de Fleetwood Mac", precio: 21.99, stock: 9, tipo: "vinilo", estado: "nuevo" },
  { nombre: "The Wall", descripcion: "Ópera rock de Pink Floyd", precio: 31.99, stock: 6, tipo: "vinilo", estado: "nuevo" },
  { nombre: "Hotel California", descripcion: "Quinto álbum de The Eagles", precio: 19.99, stock: 14, tipo: "cd", estado: "usado" },
  { nombre: "Born to Run", descripcion: "Tercer álbum de Bruce Springsteen", precio: 23.99, stock: 10, tipo: "vinilo", estado: "nuevo" }
]

productos_data.each_with_index do |data, index|
  # Seleccionar autor y categoría aleatoriamente
  autor = Autor.all.sample
  categoria = Categorium.all.sample
  
  producto = Producto.create!(
    nombre: data[:nombre],
    descripcion: data[:descripcion],
    precio: data[:precio],
    stock: data[:stock],
    tipo: data[:tipo],
    estado: data[:estado],
    autor: autor,
    categoria: categoria
  )
  
  # Crear una imagen placeholder (puedes reemplazar con imágenes reales)
  # Usando un servicio de placeholders para imágenes
  begin
    # Usar placeholder.com para generar imágenes de prueba
    image_url = "https://via.placeholder.com/500x500/#{['4F46E5', '7C3AED', 'EC4899', 'F59E0B'].sample}/FFFFFF?text=#{URI.encode_www_form_component(data[:nombre])}"
    
    downloaded_image = URI.open(image_url)
    producto.imagenes.attach(
      io: downloaded_image,
      filename: "#{data[:nombre].parameterize}.jpg",
      content_type: 'image/jpeg'
    )
  rescue => e
    puts "Error al descargar imagen para #{data[:nombre]}: #{e.message}"
  end
  
  # Si es usado, agregar audio de muestra (placeholder)
  if data[:estado] == "usado"
    begin
      # Crear un archivo de audio vacío como placeholder
      audio_file = Tempfile.new(['sample', '.mp3'])
      audio_file.write("ID3")  # Header básico de MP3
      audio_file.rewind
      
      producto.audio_muestra.attach(
        io: audio_file,
        filename: "#{data[:nombre].parameterize}_sample.mp3",
        content_type: 'audio/mpeg'
      )
      
      audio_file.close
      audio_file.unlink
    rescue => e
      puts "Error al crear audio para #{data[:nombre]}: #{e.message}"
    end
  end
  
  puts "Producto creado: #{producto.nombre} (#{producto.tipo} - #{producto.estado})"
end

puts "\n=== Resumen de Seeds ==="
puts "Usuarios: #{User.count}"
puts "Categorías: #{Categorium.count}"
puts "Autores: #{Autor.count}"
puts "Productos: #{Producto.count}"
puts "========================"