# frozen_string_literal: true

module ApplicationHelper
  def flash_message_class(key)
    return "danger" if %w(error).include?(key)
    return "warning" if %w(notice).include?(key)
    "success"
  end
end
