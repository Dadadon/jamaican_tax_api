# spec/controllers/calculate/nis_controller_spec.rb

require 'rails_helper'

RSpec.describe Calculate::NisController, type: :controller do
  describe 'POST #calculate_batch_nis' do
    it 'calculates NIS contribution for each income in the batch' do
      post :calculate_batch_nis, params: {
        batch_data: [50000, 60000, 70000]
      }

      expect(response).to have_http_status(:ok)
      nis_results = JSON.parse(response.body)['batch_results']

      expect(nis_results.length).to eq(3)
      expect(nis_results[0]['income'].to_i).to eq(50000)
      expect(nis_results[0]['nis_amount'].to_i).to eq(1500)

      expect(nis_results[1]['income'].to_i).to eq(60000)
      expect(nis_results[1]['nis_amount'].to_i).to eq(1800)

      expect(nis_results[2]['income'].to_i).to eq(70000)
      expect(nis_results[2]['nis_amount'].to_i).to eq(2100)
    end
  end
end
