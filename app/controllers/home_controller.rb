class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    @q = Producto.activos.ransack(params[:q])
    @productos = @q.result(distinct: true)
                   .includes(:autor, :categoria, imagenes_attachments: :blob)
                   .order(created_at: :desc)
                   .paginate(page: params[:page], per_page: 12)
  end
end
