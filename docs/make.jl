using PowerAnalysis
using Documenter

makedocs(;
    modules=[PowerAnalysis],
    authors="John Myles White",
    repo="https://github.com/johnmyleswhite/PowerAnalysis.jl/blob/{commit}{path}#L{line}",
    sitename="PowerAnalysis.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://johnmyleswhite.github.io/PowerAnalysis.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/johnmyleswhite/PowerAnalysis.jl",
)
