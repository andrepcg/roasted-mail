# frozen_string_literal: true

module SmsAdapters
  class GenericAdapter < Adapter
    def to_attributes
      {
        from: @params['from'],
        from_name: @params['from_name'],
        received_at: DateTime.strptime(@params['timestamp'], '%s'),
        body: @params['body'],
        to: @params['to']
      }
    end

    def files?
      false
    end
  end
end
