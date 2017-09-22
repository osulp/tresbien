# frozen_string_literal: true

class FilesController < ActionController::Base
  def upload
    @attachment = Attachment.new(attachment: params[:file])
    if(@attachment.save)
      render json: @attachment
    else
      render json: { error: "Failed to upload file" }, status: 500
    end
  end
end
