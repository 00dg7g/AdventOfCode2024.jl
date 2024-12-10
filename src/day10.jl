utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function visit(input, visited, i::Int, j::Int, height::Int, deep::Bool)
    if visited[i][j]
        return 0
    end
    visited[i][j] = true
    if input[i][j] == 9
        return 1
    end

    acc = 0
    for (h, k) in [(0, 1), (0, -1), (1, 0), (-1, 0)]
        try
            if height + 1 == input[i + h][j + k]
                next = deep ? deepcopy(visited) : visited
                acc += visit(input, next, i + h, j + k, height + 1, deep)
            end
        catch
        end
    end
    acc
end

function solve(input::Vector{Vector{Int}}, deep::Bool)
    n = length(input)
    m = length(input[1])
    ans = 0
    for i in 1:n
        for j in 1:m
            if input[i][j] == 0
                visited = map(x -> map(y -> false, 1:m), 1:n)
                ans += visit(input, visited, i, j, 0, deep)
            end
        end
    end
    ans
end

function day10(input::String)
    input = @chain input begin
        chomp
        split("\n")
        map(x -> split(x, ""), _)
        map(x -> map(parse_int, x), _)
    end

    p1 = solve(input, false)
    p2 = solve(input, true)

    @show (p1, p2)
end

day10(read_input(10))
