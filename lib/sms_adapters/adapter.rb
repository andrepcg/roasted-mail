# frozen_string_literal: true

module SmsAdapters
  class Adapter
    def initialize(params)
      @params = params
    end

    def to_attributes
      raise NotImplementedError
    end

    def parse_files
      raise NotImplementedError
    end

    def files?
      raise NotImplementedError
    end
  end
end
