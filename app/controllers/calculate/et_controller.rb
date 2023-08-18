class Calculate::EtController < ApplicationController
    def calculate_batch_et
      batch_data = params[:batch_data]
      et_rate = 0.0225  # 2.25% ET rate
  
      batch_results = calculate_batch_et_amount(batch_data, et_rate)
  
      render json: { et_rate: et_rate, batch_results: batch_results }
    end
  
    private
  
    def calculate_batch_et_amount(batch_data, et_rate)
      batch_data.map do |income|
        statutory_income = income.to_f - (income.to_f * 0.03)
        et_amount = statutory_income.to_f * et_rate
        { income: income, et_amount: et_amount }
      end
    end
  end
  