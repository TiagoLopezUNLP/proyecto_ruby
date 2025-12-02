require "test_helper"

class DetalleVentaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @detalle_ventum = detalle_venta(:one)
  end

  test "should get index" do
    get detalle_venta_url
    assert_response :success
  end

  test "should get new" do
    get new_detalle_ventum_url
    assert_response :success
  end

  test "should create detalle_ventum" do
    assert_difference("DetalleVentum.count") do
      post detalle_venta_url, params: { detalle_ventum: { cantidad: @detalle_ventum.cantidad, precio_unitario: @detalle_ventum.precio_unitario, producto_id: @detalle_ventum.producto_id, subtotal: @detalle_ventum.subtotal, venta_id: @detalle_ventum.venta_id } }
    end

    assert_redirected_to detalle_ventum_url(DetalleVentum.last)
  end

  test "should show detalle_ventum" do
    get detalle_ventum_url(@detalle_ventum)
    assert_response :success
  end

  test "should get edit" do
    get edit_detalle_ventum_url(@detalle_ventum)
    assert_response :success
  end

  test "should update detalle_ventum" do
    patch detalle_ventum_url(@detalle_ventum), params: { detalle_ventum: { cantidad: @detalle_ventum.cantidad, precio_unitario: @detalle_ventum.precio_unitario, producto_id: @detalle_ventum.producto_id, subtotal: @detalle_ventum.subtotal, venta_id: @detalle_ventum.venta_id } }
    assert_redirected_to detalle_ventum_url(@detalle_ventum)
  end

  test "should destroy detalle_ventum" do
    assert_difference("DetalleVentum.count", -1) do
      delete detalle_ventum_url(@detalle_ventum)
    end

    assert_redirected_to detalle_venta_url
  end
end
