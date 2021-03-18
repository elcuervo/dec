module Dec
  def _executor
    @_executor ||= Hash.new { |h, k| h[k] = [] }
  end

  def dec_stack
    @_stack ||= []
  end

  def dec_calls
    @_calls ||= []
  end

  def method_added(method_sym)
    return if dec_calls.include?(method_sym) || dec_stack.empty?

    dec_calls << method_sym

    _executor[method_sym] << instance_method(method_sym)
    _executor[method_sym] << dec_stack.select { |fn| fn.respond_to?(:call) }

    class_eval <<-RB, __FILE__, __LINE__ + 1
      def #{method_sym}(*args, **kwargs, &block)
         original, stack = self.class._executor[__method__]

         result = original.bind(self).call(*args, *kwargs, &block)
         stack.reverse.each { |action| result = action.call(result) }
         result
      end
    RB
  end

  def dec(*args, &block)
    @_stack = dec_stack + args << block
  end
end
