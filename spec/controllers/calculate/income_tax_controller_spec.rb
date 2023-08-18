# spec/controllers/calculate/income_tax_controller_spec.rb

require 'rails_helper'

RSpec.describe Calculate::IncomeTaxController, type: :controller do
  describe 'POST #calculate_batch' do
    it 'calculates income tax for each income in the batch' do
      post :calculate_batch, params: {
        batch_data: [200000, 150000, 100000],
        income_frequency: :monthly,
        tax_year: 2023
      }

      expect(response).to have_http_status(:ok)
      batch_results = JSON.parse(response.body)['batch_results']
      expect(batch_results.length).to eq(3)

      expect(batch_results[0]['income'].to_i).to eq(200000)
      expect(batch_results[0]['tax_amount'].to_i).to eq(17250)

      expect(batch_results[1]['income'].to_i).to eq(150000)
      expect(batch_results[1]['tax_amount'].to_i).to eq(5125)

      expect(batch_results[2]['income'].to_i).to eq(100000)
      expect(batch_results[2]['tax_amount'].to_i).to eq(0)
    end
  end
end
