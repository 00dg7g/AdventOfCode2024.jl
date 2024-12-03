utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function solve(input::String)
    input2=[]
    input = @chain input begin
        chomp
        eachmatch(r"mul\(\d+,\d+\)|do\(\)|don\'t\(\)", _)
        map(string, _)
        map(x -> replace(x, "("=>""), _)
        map(x -> replace(x, ")"=>""), _)
        map(x -> replace(x, "\""=>""), _)
        map(x -> replace(x, "RegexMatch"=>""), _)
        map(x -> replace(x, "mul"=>""), _)
        input2 = _
        filter(x -> x != "do", _)
        filter(x -> x != "don't", _)
        map(x -> split(x, ","), _)
        map(x -> map(parse_int, x), _)
    end

    p1 = sum(map(prod, input))

    p2 = 0
    enable = true
    for i in input2
        if i == "do"
            enable = true
        elseif i == "don't"
            enable = false
        elseif enable
            p2 += prod(map(parse_int, split(i, ",")))
        end
    end

    @show (p1, p2)
end

solve(read_input(3))
