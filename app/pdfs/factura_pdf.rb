# app/pdfs/factura_pdf.rb
require 'prawn'
require 'prawn/table'

class FacturaPdf < Prawn::Document
  def initialize(venta)
    super(
      page_size: 'A4',
      page_layout: :portrait,
      margin: [40, 40, 40, 40]
    )

    @venta = venta
    build_pdf
  end

  def build_pdf
    # Encabezado
    header
    move_down 30

    # Información del cliente
    info_cliente
    move_down 20

    # Tabla de productos
    productos_table
    move_down 20

    # Totales
    total_section
    move_down 30

    # Pie de página
    footer
  end

  def header
    text "FACTURA DE VENTA", size: 24, style: :bold, align: :center, color: '333333'
    text "Nº #{@venta.id.to_s.rjust(6, '0')}", size: 16, align: :center, color: '666666'
    stroke_horizontal_rule
  end

  def info_cliente
    data = [
      ["<b>Fecha:</b>", @venta.fecha.strftime('%d/%m/%Y %H:%M')],
      ["<b>Cliente:</b>", @venta.NyA_comprador || "Consumidor Final"],
      ["<b>DNI:</b>", @venta.dni_comprador || "No especificado"],
      ["<b>Vendedor:</b>", @venta.user&.email || "Sistema"]
    ]

    table(data, cell_style: { inline_format: true, border_width: 0, padding: [5, 10, 5, 0] }) do
      column(0).width = 100
      column(0).font_style = :bold
    end
  end

  def productos_table

    if @venta.detalle_ventas.empty?
      text "No hay productos en esta venta.", size: 12
      return
    end

    # Encabezados de la tabla
    data = [["<b>Producto</b>", "<b>Cantidad</b>", "<b>Precio Unit.</b>", "<b>Subtotal</b>"]]

    # Filas de productos
    @venta.detalle_ventas.each do |detalle|
      producto_nombre = detalle.producto&.nombre || "Producto no encontrado"
      # Limitar longitud del nombre si es muy largo
      nombre_truncado = producto_nombre.length > 40 ? producto_nombre[0..37] + "..." : producto_nombre

      data << [
        nombre_truncado,
        detalle.cantidad.to_s,
        "$#{number_with_delimiter(detalle.precio_unitario)}",
        "$#{number_with_delimiter(detalle.subtotal || 0)}"
      ]
    end


    page_width = bounds.width

    table(data,
          header: true,
          cell_style: {
            inline_format: true,
            border_width: 1,
            border_color: 'DDDDDD',
            padding: [6, 8],
            size: 9
          },
          column_widths: {
            0 => page_width * 0.50,  #  Producto
            1 => page_width * 0.15,  #  Cantidad
            2 => page_width * 0.17,  # Precio Unit.
            3 => page_width * 0.18   # Subtotal
          }) do

      row(0).font_style = :bold
      row(0).background_color = 'F0F0F0'
      row(0).align = :center

      # Alineación de columnas
      column(0).align = :left
      column(1).align = :center
      column(2).align = :right
      column(3).align = :right
    end
  end

  def total_section
    move_down 10


    subtotal = @venta.total || 0
    iva = subtotal * 0.19
    total = subtotal + iva

    data = [
      ["<b>SUBTOTAL:</b>", "$#{number_with_delimiter(subtotal)}"],
      ["<b>IVA (19%):</b>", "$#{number_with_delimiter(iva)}"],
      ["<b>TOTAL:</b>", "$#{number_with_delimiter(total)}"]
    ]

    table(data,
          cell_style: {
            inline_format: true,
            border_width: 0,
            padding: [8, 10, 8, 0]
          },
          position: :right,
          width: 300) do

      column(0).width = 150
      column(0).align = :right
      column(1).width = 150
      column(1).align = :right

      row(2).font_style = :bold
      row(2).size = 14
    end
  end

  def footer
    bounding_box([bounds.left, bounds.bottom + 40], width: bounds.width) do
      stroke_horizontal_rule
      move_down 10
      text "Gracias por su compra", size: 10, align: :center, color: '666666'
      text "Sistema de Ventas © #{Time.now.year}", size: 8, align: :center, color: '999999'
    end
  end

  private

  # Método para formatear números con puntos como separadores de miles
  def number_with_delimiter(number)
    number.to_i.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse
  end
end