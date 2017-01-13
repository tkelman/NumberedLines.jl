using Documenter, NumberedLines

makedocs(
    modules = [NumberedLines],
    format = :html,
    sitename = "NumberedLines.jl",
    authors = "Brandon Taylor"
)

deploydocs(
  repo = "github.com/bramtayl/NumberedLines.jl.git",
  target = "build",
  deps = nothing,
  make = nothing
)
