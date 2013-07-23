require 'test_helper'

class ProductLicensesControllerTest < ActionController::TestCase
  setup do
    @product_license = product_licenses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_licenses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_license" do
    assert_difference('ProductLicense.count') do
      post :create, product_license: { allow_regeneration: @product_license.allow_regeneration, calculated_key: @product_license.calculated_key, created_by: @product_license.created_by, email: @product_license.email, expire_date: @product_license.expire_date, is_assigned: @product_license.is_assigned, is_created: @product_license.is_created, is_deleted: @product_license.is_deleted, license_key: @product_license.license_key, machine_id: @product_license.machine_id, reset_counter: @product_license.reset_counter, updated_by: @product_license.updated_by, updated_date: @product_license.updated_date }
    end

    assert_redirected_to product_license_path(assigns(:product_license))
  end

  test "should show product_license" do
    get :show, id: @product_license
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_license
    assert_response :success
  end

  test "should update product_license" do
    put :update, id: @product_license, product_license: { allow_regeneration: @product_license.allow_regeneration, calculated_key: @product_license.calculated_key, created_by: @product_license.created_by, email: @product_license.email, expire_date: @product_license.expire_date, is_assigned: @product_license.is_assigned, is_created: @product_license.is_created, is_deleted: @product_license.is_deleted, license_key: @product_license.license_key, machine_id: @product_license.machine_id, reset_counter: @product_license.reset_counter, updated_by: @product_license.updated_by, updated_date: @product_license.updated_date }
    assert_redirected_to product_license_path(assigns(:product_license))
  end

  test "should destroy product_license" do
    assert_difference('ProductLicense.count', -1) do
      delete :destroy, id: @product_license
    end

    assert_redirected_to product_licenses_path
  end
end
