utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function part1(robots::Vector{Vector{Int}}, M::Int, N::Int)
    M, N = div(M, 2), div(N, 2)
    quadrants = [0 0; 0 0]
    for v in filter(v -> v[1] != M && v[2] != N, robots)
        quadrants[div(v[1], M + 1) + 1, div(v[2], N + 1) + 1] += 1
    end
    prod(quadrants)
end

function day14(input::String)
    input = @chain input begin
        chomp
        replace("p="=>"")
        replace(" v="=>",")
        split("\n")
        map(x -> split(x, ","), _)
        map(x -> map(parse_int, x), _)
    end

    robots = map(x -> collect(Iterators.take(x, 2)), input)
    M, N = 101, 103
    p1, p2 = 0, 0
    seconds = 1
    while p1 == 0 || p2 == 0
        for i in 1:length(robots)
            robots[i][1] = mod(robots[i][1] + input[i][3], 0:M - 1)
            robots[i][2] = mod(robots[i][2] + input[i][4], 0:N - 1)
        end

        if seconds == 100
            p1 = part1(robots, M, N)
        end
        if length(robots) == length(Set(robots)) && seconds > 1
            p2 = seconds
        end

        seconds += 1
    end

    @show (p1, p2)
end

day14(read_input(14))
