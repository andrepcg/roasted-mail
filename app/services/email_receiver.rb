# frozen_string_literal: true

class EmailReceiver
  def initialize(sendgrid_params)
    @params = sendgrid_params
    # TODO: change this to allow multiple destinataries
    @to = @params[:to].split(', ').first
  end

  def call
    @mailbox = check_destinatary_exists
    create_inbound_email
    parse_attachments
  end

  private

  def check_destinatary_exists
    Mailbox.find_by!(email: @to.downcase)
  end

  def create_inbound_email # rubocop:disable Metrics/MethodLength
    from = Mail::Address.new @params['from']
    @inbound_email = InboundEmail.create!(
      mailbox: @mailbox,
      from: from.address,
      name: from.name,
      subject: @params['subject'],
      text: @params['text'].chomp,
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
end
