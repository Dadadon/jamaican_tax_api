# app/controllers/calculate/income_tax_controller.rb
class Calculate::IncomeTaxController < ApplicationController
    def calculate_batch
      batch_data = params[:batch_data]  # Array of income data for batch processing
      income_frequency = params[:income_frequency].to_sym
      tax_year = params[:tax_year].to_i
  
      # Calculate tax for each income in the batch
      batch_results = calculate_batch_income_tax(batch_data, income_frequency, tax_year)
  
      # Return JSON response with batch results
      render json: { tax_year: tax_year, batch_results: batch_results }
    end
  
    private
  
    def calculate_batch_income_tax(batch_data, income_frequency, tax_year)
      batch_data.map do |income|
        tax_amount = calculate_income_tax(income.to_f, income_frequency, tax_year)
        { income: income, tax_amount: tax_amount }
      end
    end
  
    def calculate_income_tax(income, income_frequency, tax_year)
      # Apply Jamaican income tax rates and thresholds
      upper_threshold = 6000000
      lower_threshold = 1500000
  
      annual_income = convert_to_annual_income(income, income_frequency)
      period = convert_period(income_frequency)
      
      tax_amount = 0.0
      if annual_income > upper_threshold
        tax_amount = (( annual_income - upper_threshold ) * 0.3) / period   
      elsif annual_income > lower_threshold
        tax_amount = (( annual_income - lower_threshold ) * 0.25) / period 
      end
      tax_amount
    end
  
    def convert_to_annual_income(income, income_frequency)
      case income_frequency
      when :weekly
        income * 52
      when :fortnightly
        income * 26
      when :monthly
        income * 12
      when :annually
        income
      else
        raise ArgumentError, "Invalid income frequency"
      end
    end

    def convert_period(income_frequency)
      case income_frequency
      when :weekly
        52
      when :fortnightly
        26
      when :monthly
        12
      when :annually
        1
      else
        raise ArgumentError, "Invalid income frequency"
      end
    end
  end  
  