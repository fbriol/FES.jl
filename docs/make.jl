using Documenter
using FES

makedocs(
    sitename = "FES",
    pages = [
        "Index" => "index.md",
    ],
    format = Documenter.HTML(),
    modules = [FES]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "https://github.com/fbriol/FES.jl.git",
    devbranch = "main"
)
