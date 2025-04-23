using Coordinates
using Documenter

DocMeta.setdocmeta!(Coordinates, :DocTestSetup, :(using Coordinates); recursive=true)

makedocs(;
    modules=[Coordinates],
    authors="Abhro R. and contributors",
    sitename="Coordinates.jl",
    format=Documenter.HTML(;
        canonical="https://abhro.github.io/Coordinates.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/abhro/Coordinates.jl",
    devbranch="main",
)
