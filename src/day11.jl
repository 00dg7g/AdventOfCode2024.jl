utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain
using Memoize

@memoize function solve(stone::Int, steps::Int)
    if steps == 0
        return 1
    end

    if stone == 0
        return solve(1, steps - 1)
    end
    str = string(stone)
    l = length(str)
    if iseven(l)
        stone1 = parse_int(str[1:div(l, 2)])
        stone2 = parse_int(str[div(l, 2) + 1:end])
        return solve(stone1, steps - 1) + solve(stone2, steps - 1)
    end
    return solve(2024 * stone, steps - 1)
end

function day11(input::String)
    input = @chain input begin
        chomp
        split(" ")
        map(parse_int, _)
    end

    p1 = sum(map(stone -> solve(stone, 25), input))
    p2 = sum(map(stone -> solve(stone, 75), input))

    @show (p1, p2)
end

day11(read_input(11))
