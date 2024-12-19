utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain
using Memoize

@memoize function visit(patterns::Vector{String}, str::String)
    if str == ""
        return 1
    end

    return @chain patterns begin
        filter(p -> startswith(str, p), _)
        map(p -> visit(patterns, str[length(p) + 1:end]), _)
        sum
    end
end

function day19(input::String)
    input = split(chomp(input), "\n\n")
    patterns = map(string, split(input[1], ", "))
    designs = map(string, split(input[2], "\n"))

    p1 = 0
    p2 = 0
    for design in designs
        res = visit(patterns, design)
        p1 += res > 0
        p2 += res
    end

    @show (p1, p2)
end

day19(read_input(19))
