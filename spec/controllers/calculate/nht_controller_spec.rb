# spec/controllers/calculate/nht_controller_spec.rb

require 'rails_helper'

RSpec.describe Calculate::NhtController, type: :controller do
  describe 'POST #calculate_batch_nht' do
    it 'calculates NHT contribution for each income in the batch' do
      post :calculate_batch_nht, params: {
        batch_data: [50000, 60000, 70000]
      }

      expect(response).to have_http_status(:ok)
      nht_results = JSON.parse(response.body)['batch_results']

      expect(nht_results.length).to eq(3)
      expect(nht_results[0]['income'].to_i).to eq(50000)
      expect(nht_results[0]['nht_amount'].to_i).to eq(1000)

      expect(nht_results[1]['income'].to_i).to eq(60000)
      expect(nht_results[1]['nht_amount'].to_i).to eq(1200)

      expect(nht_results[2]['income'].to_i).to eq(70000)
      expect(nht_results[2]['nht_amount'].to_i).to eq(1400)
    end
  end
end
