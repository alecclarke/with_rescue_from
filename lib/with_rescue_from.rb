require "with_rescue_from/version"
require "active_support/concern"
require "active_support/rescuable"
require "ruby2_keywords"

module WithRescueFrom
  extend ActiveSupport::Concern

  class_methods do
    def with_rescue_from(*method_names)
      proxy = Module.new do
        method_names.each do |method_name|
          define_method(method_name) do |*args, &block|
            super(*args, &block)
          rescue => e
            rescue_with_handler(e) || raise
          end

          ruby2_keywords method_name
        end
      end

      prepend proxy
    end
  end
end
