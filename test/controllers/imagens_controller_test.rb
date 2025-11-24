require "test_helper"

class ImagensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @imagen = imagens(:one)
  end

  test "should get index" do
    get imagens_url
    assert_response :success
  end

  test "should get new" do
    get new_imagen_url
    assert_response :success
  end

  test "should create imagen" do
    assert_difference("Imagen.count") do
      post imagens_url, params: { imagen: { producto_id: @imagen.producto_id, url: @imagen.url } }
    end

    assert_redirected_to imagen_url(Imagen.last)
  end

  test "should show imagen" do
    get imagen_url(@imagen)
    assert_response :success
  end

  test "should get edit" do
    get edit_imagen_url(@imagen)
    assert_response :success
  end

  test "should update imagen" do
    patch imagen_url(@imagen), params: { imagen: { producto_id: @imagen.producto_id, url: @imagen.url } }
    assert_redirected_to imagen_url(@imagen)
  end

  test "should destroy imagen" do
    assert_difference("Imagen.count", -1) do
      delete imagen_url(@imagen)
    end

    assert_redirected_to imagens_url
  end
end
