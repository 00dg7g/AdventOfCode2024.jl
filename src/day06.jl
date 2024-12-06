utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function solve(start::Tuple{Int, Int}, input::Vector{Vector{Char}})
    dir = 1
    dirs = [(-1, 0), (0, 1), (1, 0), (0, -1)]
    visited = Set()
    i, j = start
    while true
        if (i, j, dir) in visited
            return (visited, true)
        end
        push!(visited, (i, j, dir))
        next = (i, j) .+ dirs[dir]

        try
            if input[next[1]][next[2]] == '#'
                dir = dir%4 + 1
            else
                i, j = next
            end
        catch
            return (unique(map(x -> (x[1], x[2]), collect(visited))), false)
        end
    end
end

function day06(input::String)
    input = @chain input begin
        chomp
        split("\n")
        map(collect, _)
    end
    i = findfirst(identity, map(x -> '^' in x, input))
    j = findfirst(x -> x == '^', input[i])
    start = (i, j)

    reachable = solve(start, input)[1]
    p1 = length(reachable)
    p2 = 0
    for p in reachable
        input[p[1]][p[2]] = '#'
        p2 += solve(start, input)[2]
        input[p[1]][p[2]] = '.'
    end

    @show (p1, p2)
end

day06(read_input(6))
