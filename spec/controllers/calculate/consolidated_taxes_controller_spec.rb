require 'rails_helper'

RSpec.describe Calculate::ConsolidatedTaxesController, type: :controller do
  describe 'POST #calculate_all_taxes' do
    it 'calculates all taxes for each income in the batch' do
      batch_data = [200000, 150000, 100000]
      income_frequency = :monthly
      tax_year = 2023

      post :calculate_all_taxes, params: {
        batch_data: batch_data,
        income_frequency: income_frequency,
        tax_year: tax_year
      }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['tax_year']).to eq(tax_year)

      consolidated_results = json_response['consolidated_results']
      expect(consolidated_results).to be_an(Array)
      expect(consolidated_results.size).to eq(batch_data.size)

      expected_results = [
        { 'et_amount' => 4365, 'income' => 200000, 'income_tax' => 17250, 'nht_amount' => 4000, 'nis_amount' => 6000 },
        { 'income' => 150000, 'nis_amount' => 4500, 'income_tax' => 5125, 'et_amount' => 3273.75, 'nht_amount' => 3000 },
        { 'income' => 100000, 'nis_amount' => 3000, 'income_tax' => 0, 'et_amount' => 2182.5, 'nht_amount' => 2000 }
        # Add expected results for other batch items
      ]

      consolidated_results.each_with_index do |entry, index|
        expected_entry = expected_results[index]
        expected_entry.each do |key, value|
          expect(entry[key]).to eq(value)
        end
      end
    end
  end
end
