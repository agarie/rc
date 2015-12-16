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

# A small function to fix the encoding of Windows-originated files.
def fix_encoding(fn)
  File.open(fn) do |q|
    File.open(fn, 'w') { |f| f << q.read.encode("UTF-8", "ISO-8859-1") }
  end
end
