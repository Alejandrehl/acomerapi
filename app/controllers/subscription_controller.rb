class SubscriptionController < ApplicationController

  API_URL = 'https://playground.qvo.cl' # Reemplazar por https://api.qvo.cl en producción
  API_TOKEN = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjb21tZXJjZV9pZCI6ImNvbV9TeHRoekZQd2Q0QmZsLU1XOTJSZm5BIiwiYXBpX3Rva2VuIjp0cnVlfQ.31nLRFenix9_X0qlt1ng-FUzicaFjSrkBvFAkMpiOkA' # Reemplazar por el token de producción cuando quieras pasar a producción
  
  def init
    create_customer_response = create_customer(
      name: params['name'],
      email: params['email'],
      phone: params['phone']
    )

    if create_customer_response[:error].present?
      error_message = create_customer_response[:error][:message]
      redirect_to root_path, notice: error_message
    else
      init_card_inscription_response = init_card_inscription(
        customer_id: create_customer_response[:id],
        plan_id: params['plan_id']
      )

      card_inscription_url = init_card_inscription_response[:redirect_url]
      redirect_to card_inscription_url
    end
  end

  def card_inscription_return
    uid = params[:uid];
    customer_id = params[:customer_id];
    plan_id = params[:plan_id];
    card_inscription_response = check_card_inscription(customer_id: customer_id, uid: uid);

    if card_inscription_response[:status] == 'succeeded'
      subscription_response = subscribe_customer_to_plan(
        customer_id: customer_id,
        plan_id: plan_id
      )
      redirect_to subscription_success_path(subscription_response[:id])
    else
      error_message = card_inscription_response[:error]
      redirect_to subscription_path, notice: error_message
    end
  end

  def success
    subscription_id = params['subscription_id']
    subscription_url = "#{API_URL}/subscriptions/#{subscription_id}"

    @response = HTTParty.get(
      subscription_url,
      { headers:
        {
          "Authorization" => "Bearer #{API_TOKEN}",
          'Content-Type' => 'application/json'
        }
      },
    ).body

    @response = JSON.parse(@response, symbolize_names: true)
    render :success
  end

  private
  def create_customer(name:, email:, phone:)
    create_customer_url = "#{API_URL}/customers"

    response = HTTParty.post(
      create_customer_url,
      { headers:
        {
          "Authorization" => "Bearer #{API_TOKEN}",
          'Content-Type' => 'application/json'
        },
        body: {
          'name' => name,
          'email' => email,
          'phone' => phone
        }.to_json
      },
    ).body

    return JSON.parse(response, symbolize_names: true)
  end

  def init_card_inscription(customer_id:, plan_id:)
    init_card_inscription_url = "#{API_URL}/customers/#{customer_id}/cards/inscriptions"
    return_url = subscription_card_indscription_return_url(customer_id: customer_id, plan_id: plan_id)

    response = HTTParty.post(
      init_card_inscription_url,
      { headers:
        {
          "Authorization" => "Bearer #{API_TOKEN}",
          'Content-Type' => 'application/json'
        },
        body: {
          'return_url' => return_url
        }.to_json
      },
    ).body

    return JSON.parse(response, symbolize_names: true)
  end

  def check_card_inscription(customer_id:, uid:)
    check_card_inscription_url = "#{API_URL}/customers/#{customer_id}/cards/inscriptions/#{uid}"

    response = HTTParty.get(
      check_card_inscription_url,
      { headers:
        {
          "Authorization" => "Bearer #{API_TOKEN}",
          'Content-Type' => 'application/json'
        }
      },
    ).body

    return JSON.parse(response, symbolize_names: true)
  end

  def subscribe_customer_to_plan(customer_id:, plan_id:)
    subscribe_url = "#{API_URL}/subscriptions"

    response = HTTParty.post(
      subscribe_url,
      { headers:
        {
          "Authorization" => "Bearer #{API_TOKEN}",
          'Content-Type' => 'application/json'
        },
        body: {
          'customer_id' => customer_id,
          'plan_id' => plan_id
        }.to_json
      },
    ).body

    return JSON.parse(response, symbolize_names: true)
  end
end
