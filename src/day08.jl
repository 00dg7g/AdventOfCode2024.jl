utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function antennas(input::Vector{Vector{Char}})
    res = Set()
    for i in 1:length(input)
        for j in 1:length(input[i])
            if input[i][j] != '.'
                push!(res, input[i][j])
            end
        end
    end
    res
end

function solve(input::Vector{Vector{Char}})
    p1 = Set()
    p2 = Set()
    for freq in antennas(input)
        coords = find(input, freq)
        for coord1 in 1:length(coords)
            for coord2 in coord1 + 1:length(coords)
                x1, y1 = coords[coord1]
                x2, y2 = coords[coord2]

                # Part one
                dirs = [(2x1 - x2, 2y1 - y2), (2x2 - x1, 2y2 - y1)]
                for (x, y) in dirs
                    try
                        input[x][y]
                        push!(p1, (x, y))
                    catch
                    end
                end

                # Part two
                dirs = [(x1, y1, x1 - x2, y1 - y2), (x2, y2, x2 - x1, y2 - y1)]
                for (x, y, xdiff, ydiff) in dirs
                    try
                        while true
                            input[x][y]
                            push!(p2, (x, y))
                            x, y = x + xdiff, y + ydiff
                        end
                    catch
                    end
                end
            end
        end
    end
    (length(p1), length(p2))
end

function day08(input::String)
    input = @chain input begin
        chomp
        split("\n")
        map(collect, _)
    end

    p1, p2 = solve(input)

    @show (p1, p2)
end

day08(read_input(8))
