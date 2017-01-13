using Documenter, NumberedLines

makedocs(
    modules = [NumberedLines],
    format = :html,
    sitename = "NumberedLines.jl",
    authors = "Brandon Taylor",
    pages = Any["Home" => "index.md"]
)

deploydocs(
  repo = "github.com/bramtayl/NumberedLines.jl.git",
  target = "build",
  deps = nothing,
  make = nothing
)
