# Configuration similar to the `--simple-prompt` flag.
Pry.config.prompt = [
  Proc.new { ">> " },
  Proc.new { " | " }
]

# Same as irbrc.

# Quick benchmarking.
# Based on rue's irbrc => http://pastie.org/179534
def quick(repetitions=100, &block)
  require 'benchmark'

  Benchmark.bmbm do |b|
    b.report {repetitions.times &block}
  end

  nil
end
