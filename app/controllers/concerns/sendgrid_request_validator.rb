# frozen_string_literal: true

module SendgridRequestValidator
  extend ActiveSupport::Concern

  SENDGRID_IP_RANGES = %w[127.0.0.1
                          149.72.1.0/24
                          149.72.4.0/22
                          149.72.8.0/22
                          149.72.12.0/22
                          149.72.19.0/24
                          149.72.20.0/22
                          149.72.24.0/21
                          149.72.32.0/19
                          149.72.64.0/19
                          149.72.128.0/17
                          167.89.0.0/18
                          167.89.64.0/19
                          167.89.96.0/20
                          167.89.112.0/24
                          167.89.114.0/23
                          167.89.116.0/24
                          167.89.117.0/24
                          167.89.118.0/24
                          167.89.119.0/24
                          167.89.120.0/23
                          167.89.122.0/23
                          167.89.124.0/23
                          167.89.126.0/23
                          168.245.0.0/18
                          168.245.64.0/20
                          168.245.80.0/22
                          168.245.84.0/22
                          168.245.88.0/22
                          168.245.92.0/22
                          168.245.96.0/19
                          192.254.112.0/20
                          198.21.0.0/21
                          198.37.144.0/20].map { |addr| IPAddr.new(addr) }.freeze

  included do
    before_action :validate_request
  end

  def validate_request
    result = validate(request.remote_ip)

    head :bad_request unless result
  end

  def validate(ip_addr)
    SENDGRID_IP_RANGES.each do |range|
      return true if range.include? ip_addr
    end

    false
  end
end
