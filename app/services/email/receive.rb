# frozen_string_literal: true

module Email
  class Receive
    def initialize(sendgrid_params)
      @params = sendgrid_params
      # TODO: change this to allow multiple destinataries
    end

    def call
      raise ArgumentError unless valid_params?

      @to = @params[:to].split(', ').first

      @mailbox = check_mailbox_exists
      create_inbound_email
      parse_attachments
      log_action
    end

    private

    def valid_params?
      @params['subject'] &&
        @params['headers'] &&
        @params['sender_ip'] &&
        @params['to'] &&
        @params['from']
    end

    def check_mailbox_exists
      Mailbox.find_by!(email: @to.downcase)
    end

    def create_inbound_email # rubocop:disable Metrics/MethodLength
      from = Mail::Address.new @params['from']
      @inbound_email = InboundEmail.create!(
        mailbox: @mailbox,
        from: from.address,
        name: from.name,
        subject: @params['subject'],
        text: @params['text']&.chomp,
        html: @params['html'],
        headers: @params['headers'],
        sender_ip: @params['sender_ip']
      )
    end

    def parse_attachments
      count = @params['attachments'].to_i
      attachments = count.times.map { |i| @params["attachment#{i + 1}"] }
      @inbound_email.files.attach(attachments) if attachments.present?
    end

    def log_action
      Log.create(action: :receive_email)
    end
  end
end
