require 'test_helper'

class RecursosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recurso = recursos(:one)
  end

  test "should get index" do
    get recursos_url, as: :json
    assert_response :success
  end

  test "should create recurso" do
    assert_difference('Recurso.count') do
      post recursos_url, params: { recurso: { archivo: @recurso.archivo, cnpnumero: @recurso.cnpnumero, procesado: @recurso.procesado } }, as: :json
    end

    assert_response 201
  end

  test "should show recurso" do
    get recurso_url(@recurso), as: :json
    assert_response :success
  end

  test "should update recurso" do
    patch recurso_url(@recurso), params: { recurso: { archivo: @recurso.archivo, cnpnumero: @recurso.cnpnumero, procesado: @recurso.procesado } }, as: :json
    assert_response 200
  end

  test "should destroy recurso" do
    assert_difference('Recurso.count', -1) do
      delete recurso_url(@recurso), as: :json
    end

    assert_response 204
  end
end
