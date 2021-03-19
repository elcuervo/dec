require "spec_helper"
require "benchmark"
require "benchmark/ips"

describe "Dec Bench" do
  it do
    class With
      extend Dec

      dec { |r| r ** 2 }
      dec { |r| r ** 3 }
      def sum(a, b)
        a + b
      end
    end

    class Without
      def sum(a, b)
        a + b
      end
    end

    n = 1_000

    Benchmark.ips do |x|
      x.report(With) do
        n.times { With.new.sum(1, 2) }
      end

      x.report(Without) do
        n.times { Without.new.sum(1, 2) }
      end

      x.compare!
    end
  end
end
