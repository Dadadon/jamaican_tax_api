# test/controllers/calculate/income_tax_controller_test.rb
require 'test_helper'

class Calculate::IncomeTaxControllerTest < ActionDispatch::IntegrationTest
  test "should calculate income tax for batch" do
    post calculate_income_tax_batch_path, params: {
      batch_data: [50000, 100000, 150000],
      income_frequency: "monthly",
      tax_year: 2023
    }

    assert_response :success
    response_data = JSON.parse(response.body)
    assert_equal 2023, response_data["tax_year"]
    assert_equal 3, response_data["batch_results"].size
    # Add more assertions based on your expectations
  end

  # Add more test cases for different scenarios
end

