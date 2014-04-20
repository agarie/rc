# Configuration similar to the `--simple-prompt` flag.
Pry.config.prompt = [
  Proc.new { ">> " },
  Proc.new { " | " }
]
