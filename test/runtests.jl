using NumberedLines
import Documenter

Documenter.makedocs(
  modules = NumberedLines,
  root = joinpath(dirname(dirname(@__FILE__)), "docs"),
  format = :html,
  sitename = "NumberedLines",
  pages = ["index.md"],
  authors = "Brandon Taylor",
  strict = true
)
