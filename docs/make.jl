using Documenter, NumberedLines

makedocs()

deploydocs(
  repo = "github.com/bramtayl/NumberedLines.jl.git",
  target = "build",
  deps = nothing,
  make = nothing
)
