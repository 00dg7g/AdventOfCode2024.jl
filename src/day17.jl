utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function run(instructions::Vector{Int}, a::Int, b::Int, c::Int)
    ip = 0
    out = Vector{Int}()
    l = length(instructions)
    while ip + 2 <= l
        instruction = instructions[ip + 1]
        operand = instructions[ip + 2]
        combo = 0
        if 0 <= operand <= 3
            combo = operand
        elseif operand == 4
            combo = a
        elseif operand == 5
            combo = b
        elseif operand == 6
            combo = c
        end
        ip += 2
        if instruction == 0
            a = div(a, 2 ^ combo)
        elseif instruction == 1
            b = b ⊻ operand
        elseif instruction == 2
            b = combo % 8
        elseif instruction == 3
            if a !=  0
                ip = operand
            end
        elseif instruction == 4
            b = b ⊻ c
        elseif instruction == 5
            push!(out, combo % 8)
        elseif instruction == 6
            b = div(a, 2 ^ combo)
        elseif instruction == 7
            c = div(a, 2 ^ combo)
        end
    end

    out
end

function day17(input::String)
    input = @chain input begin
        replace(r"Register [ABC]: "=>"")
        replace("Program: "=>"")
        split("\n\n")
    end
    a, b, c = map(parse_int, split(input[1], "\n"))
    instructions = map(parse_int, split(input[2], ","))

    p1 = @chain run(instructions, a, b, c) begin
        map(string, _)
        map(x -> x * ",", _)
        foldl(*, _)
        chop
    end

    p2 = 0
    for n in 0:15
        for tmp in 0:7
            a = (p2 << 3) + tmp
            if run(instructions, a, b, c)[end - n] == instructions[end - n]
                p2 = a
                break
            end
        end
    end

    @show (p1, p2)
end

day17(read_input(17))
