# frozen_string_literal: true

require 'ostruct'

module Interact
  module Helpers
    module OptionHelpers
      def parse_options(options, *required, **defaults)
        options = defaults.merge! options
        required
          .reject { |opt| options.key? opt }
          .each { |opt| raise_missing_option options, opt }
        OpenStruct.new(options).freeze
      end

      def ensure_enum(opt, name, enum)
        return if enum.include? opt
        raise ArgumentError, "Option '#{name}' must be one of #{enum} but it was '#{opt}'"
      end

      def ensure_enum_or_numeric(opt, name, enum)
        return if in_enum_or_numeric? opt, enum
        raise ArgumentError, "Option '#{name}' must be numeric or one of #{enum} but it was '#{opt}'"
      end

      def ensure_numeric(opt, name)
        return if opt.is_a? Numeric
        raise ArgumentError, "Option '#{name}' must be numeric but it was '#{opt}'"
      end

      def ensure_hash_schema(hash_opt, name, *schemas, allow_missing_keys: false)
        return if schemas.any? do |schema|
          missing_keys = schema.keys - hash_opt.keys
          additional_keys = hash_opt.keys - schema.keys

          if additional_keys.empty? and (allow_missing_keys or missing_keys.empty?)
            hash_opt.all? { |key, value| value.is_a? schema[key] }
          else
            false
          end
        end

        raise ArgumentError, "Option '#{name}' must be a hash with one of these schemas: #{schemas.join "\n"}"
      end

      private

      def raise_missing_option(options, option)
        raise ArgumentError, "Missing option #{option.inspect} in #{options.inspect}"
      end

      def in_enum_or_numeric?(opt, enum)
        opt.is_a? Numeric or enum.include? opt
      end
    end
  end
end
