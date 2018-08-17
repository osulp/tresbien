# frozen_string_literal: true

if %w[production staging].include? Rails.env
  Datadog.configure do |c|
    c.use :rails, service_name: "tresbien-#{Rails.env}"
    c.use :http, service_name: "tresbien-#{Rails.env}-http"
  end
end
