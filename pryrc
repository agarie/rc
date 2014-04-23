# Configuration similar to the `--simple-prompt` flag.
Pry.config.prompt = [
  Proc.new { ">> " },
  Proc.new { " | " }
]

#
# There functions are copied from the irbrc file. Blabla, copy-pasting is bad
# and stuff, but for the time being I won't spend too much time on this.
#

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
  q = File.read(fn)
  File.open(fn, 'w') { |f| f << q.encode("UTF-8", "ISO-8859-1") }
end
