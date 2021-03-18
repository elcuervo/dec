require "spec_helper"
require "pry"

describe Dec do
  class Test
    extend Dec

    square = -> (r) { r ** 2 }
    cube =   -> (r) { r ** 3 }

    dec { |r| r / 2 }
    dec square
    dec cube
    def sum(a, b)
      a + b
    end
  end

  it do
    initial = [1, 2]
    expected = ((initial.inject(:+) ** 3) ** 2) / 2

    assert_equal expected, Test.new.sum(*initial)
  end
end
