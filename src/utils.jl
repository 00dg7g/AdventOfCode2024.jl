using Printf

function read_input(day::Integer)
    path = joinpath(@__DIR__, "..", "input", @sprintf("day%02d.txt", day))
    input = open(path, "r") do file
        read(file, String)
    end
    return input
end
export read_input

parse_int(str::AbstractString) = parse(Int, str)
export parse_int

function find(input::Vector{Vector{Any}}, x::Any)
    res = []
    for i in 1:length(input)
        for j in 1:length(input[i])
            if input[i][j] == x
                push!(res, (i, j))
            end
        end
    end
    res
end
export find

isclose(x::Float64, eps::Float64) = round(x) - eps <= x <= round(x) + eps
export isclose
