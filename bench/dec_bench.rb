require "spec_helper"
require "benchmark"

describe "Dec Bench" do
  it do
    class With
      include Dec

      dec { |r| r ** 2 }
      def sum(a, b)
        a + b
      end
    end

    class Without
      def sum(a, b)
        a + b
      end
    end

    n = 1_000_000

    Benchmark.bmbm do |x|
      x.report(With) do
        n.times { With.new.sum(1, 2) }
      end

      x.report(Without) do
        n.times { Without.new.sum(1, 2) }
      end
    end
  end
end
