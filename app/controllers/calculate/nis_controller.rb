class Calculate::NisController < ApplicationController
    def calculate_batch_nis
      batch_data = params[:batch_data]
      nis_rate = 0.03  # 3% NIS rate
  
      batch_results = calculate_batch_nis_amount(batch_data, nis_rate)
  
      render json: { nis_rate: nis_rate, batch_results: batch_results }
    end
  
    private
  
    def calculate_batch_nis_amount(batch_data, nis_rate)
        batch_data.map do |income|
          nis_amount = income.to_f * nis_rate
          { income: income, nis_amount: nis_amount }
        end
    end
  end  
