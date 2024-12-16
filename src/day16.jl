utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain
using DataStructures

dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)]

function day16(input::String)
    input = @chain input begin
        chomp
        split("\n")
        map(collect, _)
    end
    start = find(input, 'S')[1]
    stop = find(input, 'E')[1]

    pq = PriorityQueue{Tuple{Int, Int, Int}, Int}(Base.Order.Forward)
    pq[(start[1], start[2], 1)] = 0
    prev = Dict()
    prev[(start[1], start[2], 1)] = []
    curr = peek(pq)[1]
    while true
        i, j, dir = peek(pq)[1]
        if (i, j) == stop
            break
        end
        clockdir = mod(dir + 1, 1:4)
        counterclockdir = mod(dir - 1, 1:4)
        for d in [dir, clockdir, counterclockdir]
            h, k = dirs[d]
            if input[i + h][j + k] != '#'
                triple = (i + h, j + k, d)
                score = pq[(i, j, dir)] + (d == dir ? 1 : 1001)
                if (triple in keys(pq)) && score == pq[triple]
                    prev[triple] = unique(vcat(prev[triple], prev[i, j, dir]))
                end
                if !(triple in keys(pq))
                    pq[triple] = score
                    prev[triple] = vcat(prev[(i, j, dir)], [(i, j, dir)])
                end
            end
        end
        dequeue!(pq)
    end

    p1 = peek(pq)[2]
    p2 = length(prev[peek(pq)[1]]) + 1

    @show (p1, p2)
end

day16(read_input(16))
