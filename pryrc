# Load .irbrc in order to load its function definitions.
# require '.irbrc'

# Configuration similar to the `--simple-prompt` flag.
Pry.config.prompt = [
  Proc.new { ">> " },
  Proc.new { " | " }
]
