utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function solve(v::Vector{Int})
    A = [v[1] v[3]; v[2] v[4]]
    b = [v[5]; v[6]]
    x = A \ b
    return all(map(y -> isclose(y, 0.01), x)) ? 3round(x[1]) + round(x[2]) : 0
end

function day13(input::String)
    input = @chain input begin
        chomp
        replace("Button A: "=>"")
        replace("\nButton B: "=>", ")
        replace("\nPrize: "=>", ")
        replace(r"[XY+=]"=>"")
        split("\n\n")
        map(x -> split(x, ", "), _)
        map(x -> map(parse_int, x), _)
    end

    p1, p2 = 0, 0
    for i in 1:length(input)
        p1 += solve(input[i])
        input[i][5] += 10000000000000
        input[i][6] += 10000000000000
        p2 += solve(input[i])
    end
    p1, p2 = Int(p1), Int(p2)

    @show p1, p2
end

day13(read_input(13))
