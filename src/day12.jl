utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function perimeter(region)
    p = 0
    for (i, j) in region
        for (h, k) in [(0, 1), (0, -1), (1, 0), (-1, 0)]
            if !((i + h, j + k) in region)
                p += 1
            end
        end
    end
    p
end

area(region) = length(region)

function sides(region, n, m)
    sides = 0
    for i in 1:n
        for h in [1, -1]
            prev = false
            for j in 1:m
                curr = (i, j) in region && !((i + h, j) in region)
                sides += curr && !prev
                prev = curr
            end
        end
    end
    for j in 1:m
        for k in [1, -1]
            prev = false
            for i in 1:n
                curr = (i, j) in region && !((i, j + k) in region)
                sides += curr && !prev
                prev = curr
            end
        end
    end
    sides
end

function visit!(input, visited, i, j, region, plot)
    try
        if visited[i][j] || input[i][j] != plot
            return
        end
    catch
        return
    end

    visited[i][j] = true
    push!(region, (i, j))
    for (h, k) in [(0, 1), (0, -1), (1, 0), (-1, 0)]
        visit!(input, visited, i + h, j + k, region, plot)
    end
end

function day12(input::String)
    input = @chain input begin
        chomp
        split("\n")
        map(collect, _)
    end

    p1, p2 = 0, 0
    n, m = length(input), length(input[1])
    visited = map(x -> map(y -> false, 1:m), 1:n)
    for i in 1:n
        for j in 1:m
            if visited[i][j]
                continue
            end
            region = Set()
            visit!(input, visited, i, j, region, input[i][j])
            p1 += area(region) * perimeter(region)
            p2 += area(region) * sides(region, n, m)
        end
    end

    @show (p1, p2)
end

day12(read_input(12))
