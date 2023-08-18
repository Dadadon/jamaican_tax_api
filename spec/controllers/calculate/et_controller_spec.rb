# spec/controllers/calculate/et_controller_spec.rb

require 'rails_helper'

RSpec.describe Calculate::EtController, type: :controller do
  describe 'POST #calculate_batch_et' do
    it 'calculates ET contribution for each income in the batch' do
      post :calculate_batch_et, params: {
        batch_data: [50000, 60000, 70000]
      }

      expect(response).to have_http_status(:ok)
      et_results = JSON.parse(response.body)['batch_results']

      expect(et_results.length).to eq(3)
      expect(et_results[0]['income'].to_i).to eq(50000)
      expect(et_results[0]['et_amount'].to_i).to eq(1091)

      expect(et_results[1]['income'].to_i).to eq(60000)
      expect(et_results[1]['et_amount'].to_i).to eq(1309)

      expect(et_results[2]['income'].to_i).to eq(70000)
      expect(et_results[2]['et_amount'].to_i).to eq(1527)
    end
  end
end
