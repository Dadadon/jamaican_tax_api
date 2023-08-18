# Jamaican Tax API Documentation

Welcome to the Jamaican Tax API documentation. This guide provides an overview of the available endpoints, request and response formats, rate limiting, error handling, and other important information for using the API.

## Table of Contents
- [Key Features](#key-features)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [API Endpoints](#api-endpoints)
- [Error Handling](#error-handling)
- [Future Features](#future-features)
- [License](#license)
- [Author](#author)

## Key Features

- Calculate income tax, NIS contributions, NHT contributions, and ET contributions.
- Batch processing for multiple incomes and tax calculations.
- Rate limiting to prevent abuse.
- Data validation to ensure accurate calculations.
- No need for API keys.

## Tech Stack

The Jamaican Tax API is built using the following technologies:

- Ruby on Rails
- Rack Attack for rate limiting
- RSpec for testing

## Getting Started

To get started with this project, follow these steps:

1. Clone the repository from GitHub:
   ```sh
   git clone https://github.com/your-username/your-repo.git
   cd your-repo

2. Install the required gems:
    ```sh
    bundle install

3. Start the server:
    ```sh
    rails server

4. The API should now be accessible at http://localhost:3000.

# API Endpoints
## Calculate Consolidated Taxes

    URL: /calculate/consolidated_taxes
    Method: POST
    Request Body:   batch_data (array of numbers): Array of income amounts to calculate income tax for.
                    income_frequency (string): Frequency of income (weekly, fortnightly, monthly, annually).
                    tax_year (number): Tax year for calculations.
    Example Request:json
                    POST /calculate/income-tax/batch
                    {
                        "batch_data": [200000, 150000, 100000],
                        "income_frequency": "monthly",
                        "tax_year": 2023
                    }
    Example Response: HTTP/1.1 200 OK
                    {
                      "tax_year": 2023,
                      "consolidated_results": [
                        {
                          "income": 200000,
                          "nis_amount": 6000,
                          "income_tax": 17250,
                          "et_amount": 4365,
                          "nht_amount": 4000
                        },
                        {
                          "income": 150000,
                          "nis_amount": 4500,
                          "income_tax": 5125,
                          "et_amount": 3273.75,
                          "nht_amount": 3000
                        },
                        {
                          "income": 100000,
                          "nis_amount": 3000,
                          "income_tax": 0,
                          "et_amount": 2182.5,
                          "nht_amount": 2000
                        }
                      ]
                    }

    Error Responses:    400 Bad Request: Invalid request parameters.
                        429 Too Many Requests: Rate limit exceeded.


## Calculate Income Tax Batch

    URL: /calculate/income-tax/batch
    Method: POST
    Request Body:   batch_data (array of numbers): Array of income amounts to calculate income tax for.
                    income_frequency (string): Frequency of income (weekly, fortnightly, monthly, annually).
                    tax_year (number): Tax year for calculations.
    Example Request:json
                    POST /calculate/income-tax/batch
                    {
                        "batch_data": [200000, 150000, 100000],
                        "income_frequency": "monthly",
                        "tax_year": 2023
                    }
    (Response and error format similar to the consolidated taxes endpoint)


## Calculate NIS Batch

    URL: /calculate/nis/batch
    Method: POST
    Request Body:   batch_data (array of numbers): Array of income amounts to calculate NIS contributions for.
    Example Request:json
                    POST /calculate/nis/batch
                    {
                        "batch_data": [200000, 150000, 100000]
                    }

    (Response and error format similar to the consolidated taxes endpoint)


## Calculate NHT Batch

    Calculate NHT (National Housing Trust) contributions for a batch of incomes.

    URL: /calculate/nht/batch
    Method: POST
    Request Body:   batch_data (array of numbers): Array of income amounts to calculate NHT contributions for.
    Example Request:json
                    POST /calculate/nht/batch
                    {
                      "batch_data": [200000, 150000, 100000]
                    }

    (Response format similar to the consolidated taxes endpoint)


## Calculate ET Batch

    Calculate ET (Education Tax) contributions for a batch of incomes.

    URL: /calculate/et/batch
    Method: POST
    Request Body:   batch_data (array of numbers): Array of income amounts to calculate ET contributions for.
    Example Request:json
                    POST /calculate/et/batch
                    {
                      "batch_data": [200000, 150000, 100000]
                    }

    (Response format similar to the consolidated taxes endpoint)



# Error Handling

The API returns appropriate HTTP status codes along with error messages in case of invalid requests or other errors. Please refer to the specific endpoint documentation for details on possible error responses.



# Future Features
    Enhanced logging and monitoring.
    Content Security Policy (CSP) for embedded content.



# License

The Jamaican Tax API is open-source software licensed under the [MIT](https://opensource.org/license/mit/) License.



# Author 

👤 **Davian Beroni**

- GitHub: [dadadon](https://github.com/dadadon)
- Twitter: [Davian Beroni](https://twitter.com/davianberoni)
- LinkedIn: [Davian Beroni](https://www.linkedin.com/in/davian-beroni/)



## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## ⭐️ Show your support <a name="support"></a>

Give a ⭐️ if you like this project!

<p align="right">(<a href="#readme-top">back to top</a>)</p>


