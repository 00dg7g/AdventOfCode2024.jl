utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain
using DataStructures

function distances(
    input::Vector{Vector{Char}},
    start::Tuple{Int, Int},
    stop::Tuple{Int, Int}
)
    v = Dict{Tuple{Int, Int}, Int}()
    q = Queue{Tuple{Int, Int}}()
    enqueue!(q, start)
    v[start] = 0

    while length(q) > 0
        i, j = dequeue!(q)
        dist = v[(i, j)]
        if (i, j) == stop
            return v
        end
        for (h, k) in [(1, 0), (-1, 0), (0, 1), (0, -1)]
            try
                if input[i + h][j + k] != '#' && !((i + h, j + k) in keys(v))
                    enqueue!(q, (i + h, j + k))
                    v[(i + h, j + k)] = dist + 1
                end
            catch
            end
        end
    end
end

function solve(dists::Dict{Tuple{Int, Int}, Int}, n::Int, m::Int, longest::Int)
    result = 0
    for (i, j) in keys(dists)
        for (h, k) in keys(dists)
            taxi = abs(i - h) + abs(j - k)
            if 0 < taxi <= n
                l = dists[(i, j)] + taxi + longest - dists[(h, k)]
                if longest - l >= m
                    result += 1
                end
            end
        end
    end
    result
end

function day20(input::String)
    input = @chain input begin
        chomp
        split("\n")
        map(collect, _)
    end
    start = find(input, 'S')[1]
    stop = find(input, 'E')[1]

    dists = distances(input, start, stop)
    p1 = solve(dists, 2, 100, dists[stop])
    p2 = solve(dists, 20, 100, dists[stop])

    @show (p1, p2)
end

day20(read_input(20))
