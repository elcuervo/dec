# frozen_string_literal: true

module Dec
  HASH_ARRAY = -> (h, k) { h[k] = [] }
  NS = "_dec_".freeze

  def _executor
    @_dec_executor ||= Hash.new(&HASH_ARRAY)
  end

  def dec_stack
    @_dec_stack ||= []
  end

  def dec_calls
    @_dec_calls ||= []
  end

  def method_added(method_sym)
    return if method_sym.to_s.start_with?(NS) || dec_calls.include?(method_sym) || dec_stack.empty?

    dec_calls << method_sym

    alias_method :"#{NS}#{method_sym}", method_sym

    _executor[method_sym] = dec_stack.select { |fn| fn.respond_to?(:call) }.reverse

    class_eval <<-RB, __FILE__, __LINE__ + 1
      def #{method_sym}(*args, **kwargs, &block)
        result = send(:#{NS}#{method_sym}, *args, *kwargs, &block)
        stack = self.class._executor[:#{method_sym}]

        stack.each { |action| result = action.call(result) }
        result
      end
    RB
  end

  def dec(*args, &block)
    @_dec_stack = dec_stack + args << block
  end
end
