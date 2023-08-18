class Calculate::NhtController < ApplicationController
    def calculate_batch_nht
      batch_data = params[:batch_data]
      nht_rate = 0.02  # 2% NHT rate
  
      batch_results = calculate_batch_nht_amount(batch_data, nht_rate)
  
      render json: { nht_rate: nht_rate, batch_results: batch_results }
    end
  
    private
  
    def calculate_batch_nht_amount(batch_data, nht_rate)
      batch_data.map do |income|
        nht_amount = income.to_f * nht_rate
        { income: income, nht_amount: nht_amount }
      end
    end
  end
  