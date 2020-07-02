# frozen_string_literal: true

require 'uri'

module SmsAdapters
  class TwilioAdapter < Adapter
    def to_attributes
      {
        from: @params[:From],
        to: @params[:To],
        body: @params[:Body],
        received_at: DateTime.now
      }
    end

    def parse_files
      @params[:NumMedia].to_i.times.map do |i|
        content_type = @params["MediaContentType#{i}"]
        {
          io: URI.open(@params["MediaUrl#{i}"]),
          content_type: content_type,
          filename: "#{SecureRandom.hex}.#{Mime::Type.lookup(content_type).symbol}"
        }
      end
    end

    def files?
      @params['NumMedia'].to_i.positive?
    end
  end
end
