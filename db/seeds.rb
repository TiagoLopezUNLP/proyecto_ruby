# Limpiar datos existentes (opcional, ten cuidado en producción)
puts "Limpiando base de datos..."
Producto.destroy_all
Categorium.destroy_all
Autor.destroy_all
User.destroy_all

# Crear usuarios
puts "Creando usuarios..."
admin = User.create!(
  email: "tiagovlopez@gmail.com",
  password: "123456789",
  password_confirmation: "123456789",
  role: "administrador"
)

usuario = User.create!(
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