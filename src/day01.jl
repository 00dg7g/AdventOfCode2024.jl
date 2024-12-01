utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function solve(input::String)
    input = @chain input begin
        replace("   "=>"\n")
        chomp
        split("\n")
        map(parse_int, _)
    end

    l1 = map(x -> input[x], 1:2:length(input))
    l2 = map(x -> input[x], 2:2:length(input))

    p1 = sum(map((x, y) -> abs(x - y), l1, l2))

    p2 = sum(map(x -> x * count(y -> y == x, l2), l1))

    @show (p1, p2)
end

solve(read_input(1))
