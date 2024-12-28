utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function toheights(str::Vector{Vector{Char}})
    str = collect(eachrow(reduce(hcat, str)))
    map(v -> count(c -> c == '#', v), str)
end

function day25(input::String)
    input = @chain input begin
        chomp
        split("\n\n")
        map(x -> split(x, "\n"), _)
        map(x -> map(collect, x), _)
    end

    locks = map(toheights, filter(x -> x[1][1] == '#', input))
    keys = map(toheights, filter(x -> x[1][1] == '.', input))

    p1 = 0
    for lock in locks
        for key in keys
            p1 += maximum(lock + key) < 8
        end
    end

    @show (p1, nothing)
end

day25(read_input(25))
