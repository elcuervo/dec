require "spec_helper"

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

    def string
      "potato"
    end
  end

  it do
    t = Test.new

    initial = [1, 2]
    expected = ((initial.inject(:+) ** 3) ** 2) / 2

    assert_equal expected, t.sum(*initial)
    assert_equal "potato", t.string
  end
end
