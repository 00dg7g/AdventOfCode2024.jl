utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function solve(v::Vector{Int}, retry::Bool)
    sign = v[1] - v[2]
    for i in 1:length(v) - 1
        diff = v[i] - v[i + 1]
        if  !(0 < abs(diff) < 4 && diff * sign > 0)
            if retry
                w = copy(v)
                deleteat!(w, i)
                deleteat!(v, i + 1)
                return solve(v, false) || solve(w, false)
            else
                return false
            end
        end
    end
    true
end

function day02(input::String)
    input = @chain input begin
        chomp
        split("\n")
        map(x -> split(x, " "), _)
        map(x -> map(parse_int, x), _)
    end

    p1 = sum(map(x -> solve(x, false), input))

    p2 = sum(map(x -> solve(x, true), input))

    @show (p1, p2)
end

day02(read_input(2))
