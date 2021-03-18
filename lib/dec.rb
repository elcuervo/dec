module Dec
  module M
    def dec_stack
      @_stack ||= []
    end

    def dec_calls
      @_calls ||= []
    end

    def method_added(method_sym)
      return if dec_calls.include?(method_sym) || dec_stack.empty?

      dec_calls << method_sym

      original = instance_method(method_sym)
      stack = dec_stack.select { |fn| fn.respond_to?(:call) }

      define_method(method_sym) do |*args, **kwargs, &block|
        result = original.bind(self).call(*args, *kwargs, &block)
        stack.reverse.each { |action| result = action.call(result) }
        result
      end
    end

    def dec(*args, &block)
      @_stack = dec_stack + args << block
    end
  end

  def self.included(base)
    base.extend(M)
  end
end
