utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain
using DataStructures

function bfs(M::Matrix{Bool}, N::Int)
    (i, j) = (1, 1)
    stop = (N + 1, N + 1)
    q = Queue{Tuple{Int, Int, Int}}()
    visited = Set{Tuple{Int, Int}}()
    enqueue!(q, (i, j, 0))
    push!(visited, (i, j))
    while length(q) > 0
        i, j, dist = dequeue!(q)
        if (i, j) == stop
            return dist
        end
        for (h, k) in [(1, 0), (-1, 0), (0, 1), (0, -1)]
            try
                if M[i + h, j + k] && !((i + h, j + k) in visited)
                    enqueue!(q, (i + h, j + k, dist + 1))
                    push!(visited, (i + h, j + k))
                end
            catch
            end
        end
    end
    return -1
end

function day18(input::String)
    input = @chain input begin
        chomp
        split("\n")
        map(x -> split(x, ","), _)
        map(x -> map(parse_int, x), _)
    end

    N = 70
    M = ones(Bool, N + 1, N + 1)

    p1 = 0
    p2 = 0
    for x in 1:length(input)
        i, j = input[x]
        M[i + 1, j + 1] = false

        if x == 1024
            p1 = bfs(M, N)
        end

        if bfs(M, N) == -1
            p2 = "$i,$j"
            break
        end
    end

    @show (p1, p2)
end

day18(read_input(18))
