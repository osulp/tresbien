# frozen_string_literal: true

::APPLICATION_CONFIG = { statuses: YAML.load_file(Rails.root.join('config/status.yml')) }.freeze
