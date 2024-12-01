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
