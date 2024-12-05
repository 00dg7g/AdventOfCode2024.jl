utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function solve(input::String)
    input = split(input, "\n\n")
    rules = @chain input[1] begin
        split("\n")
        map(x -> split(x, "|"), _)
        map(x -> map(parse_int, x), _)
        Set
    end
    updates = @chain input[2] begin
        chomp
        split("\n")
        map(x -> split(x, ","), _)
        map(x -> map(parse_int, x), _)
    end

    p1 = 0
    p2 = 0
    for z in 1:length(updates)
        update = updates[z]
        correct = true

        for i in 1:length(update)
            for j in i + 1:length(update)
                if [update[j], update[i]] in rules
                    correct = false
                    tmp = update[j]
                    update[j] = update[i]
                    update[i] = tmp
                end
            end
        end

        value = update[div(length(update), 2) + 1]
        if correct
            p1 += value
        else
            p2 += value
        end
    end

    @show (p1, p2)
end

solve(read_input(5))
