class Calculate::ConsolidatedTaxesController < ApplicationController
  def calculate_all_taxes
    batch_data = params[:batch_data]
    income_frequency = params[:income_frequency].to_sym
    tax_year = params[:tax_year].to_i

    consolidated_results = calculate_consolidated_taxes(batch_data, income_frequency, tax_year)

    render json: { tax_year: tax_year, consolidated_results: consolidated_results }
  end

  private

  def calculate_consolidated_taxes(batch_data, income_frequency, tax_year)
    consolidated_results = []

    batch_data.each do |income|
      nis_amount = calculate_nis(income.to_f)
      statutory_income = income.to_f - nis_amount.to_f
      income_tax = calculate_income_tax(statutory_income, income_frequency, tax_year)
      et_amount = calculate_et(statutory_income)
      nht_amount = calculate_nht(income.to_f)

      consolidated_results << {
        income: income.to_f,
        nis_amount: nis_amount,
        income_tax: income_tax,
        et_amount: et_amount,
        nht_amount: nht_amount
      }
    end

    consolidated_results
  end

  def calculate_nis(income)
    nis_rate = 0.03  # 3% NIS rate
    income * nis_rate
  end

  def calculate_income_tax(income, income_frequency, tax_year)
    # Apply Jamaican income tax rates and thresholds
    upper_threshold = 6000000
    lower_threshold = 1500000

    annual_income = convert_to_annual_income(income, income_frequency)
    period = convert_period(income_frequency)

    tax_amount = 0.0
    if annual_income > upper_threshold
      tax_amount = ((annual_income - upper_threshold) * 0.3) / period
    elsif annual_income > lower_threshold
      tax_amount = ((annual_income - lower_threshold) * 0.25) / period
    end

    # Apply additional logic based on the tax year if needed
    if tax_year == 2023
      # Apply tax rules specific to the year 2023
      # For example, adjust tax brackets or rates
    end

    tax_amount
  end

  def calculate_et(income)
    et_rate = 0.0225  # 2.25% ET rate
    income * et_rate
  end

  def calculate_nht(income)
    nht_rate = 0.02  # 2% NHT rate
    income * nht_rate
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
