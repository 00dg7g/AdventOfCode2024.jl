utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

concatenation(a, b) = parse_int("$a$b")

function check2(line::Vector{Int}, ops::Vector{Function}, i::Int, acc::Int)
    if acc > line[1]
        return false
    end
    if i > length(line)
        return acc == line[1]
    end

    for op in ops
        if check(line, ops, i + 1, op(acc, line[i]))
            return true
        end
    end
    false
end

solve(input::Vector{Vector{Int}}, ops::Vector{Function}) =
    sum(map(first, filter(line -> check(line, ops, 3, line[2]), input)))

function day07(input::String)
    input = @chain input begin
        chomp
        replace(":"=>"")
        split("\n")
        map(x -> split(x, " "), _)
        map(x -> map(parse_int, x), _)
    end

    p1 = solve(input, [+, *])
    p2 = solve(input, [+, *, concatenation])

    @show (p1, p2)
end

day07(read_input(7))
