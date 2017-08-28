# frozen_string_literal: true

STATUS = YAML.load_file("#{Rails.root}/config/status.yml")[Rails.env]
