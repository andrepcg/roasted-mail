# frozen_string_literal: true

module SmsService
  class Create
    def initialize(sms_adapter)
      @adapter = sms_adapter
    end

    def call
      validate_destinatary
      create_sms
      attach_files
      create_log
    end

    private

    def validate_destinatary
      @phone_number = PhoneNumber.find_by!(number: @adapter.to_attributes[:to])
    end

    def create_sms
      @sms = ::InboundSms.create!(@adapter.to_attributes.merge(phone_number: @phone_number))
    end

    def attach_files
      return unless @adapter.files?

      @adapter.parse_files.each do |f|
        @sms.files.attach(io: f[:io], content_type: f[:content_type], filename: f[:filename])
      end
    end

    def create_log
      Log.create(action: :receive_sms)
    end
  end
end
