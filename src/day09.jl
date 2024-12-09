utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

checksum(exp::Vector{Int}) = @chain exp begin
    map(*, _, 0:length(exp) - 1)
    filter(x -> x > 0, _)
    sum
end

function part1(exp::Vector{Int})
    left = findnext(x -> x == -1, exp, 1)
    right = findprev(x -> x != -1, exp, length(exp))

    while left <= right
        exp[left] = exp[right]
        exp[right] = -1

        left = findnext(x -> x == -1, exp, left + 1)
        right = findprev(x -> x != -1, exp, right - 1)
    end
    checksum(exp)
end

function part2(input::Vector{Int}, exp::Vector{Int})
    spaces = map(y -> input[y], 2:2:length(input))
    blocks = map(x -> input[x], 1:2:length(input))
    cumulative = map(x -> x + 1, cumsum(input))
    ispaces = @chain cumulative begin
        map(x -> _[x], 1:2:length(_))
        Iterators.take(_, length(_) - 1)
        collect
    end
    iblocks = @chain cumulative begin
        map(x ->_[x], 2:2:length(_))
        append!([1], _)
    end

    for i in length(blocks):-1:1
        for j in 1:length(spaces)
            if spaces[j] >= blocks[i] && ispaces[j] < iblocks[i]
                for z in 1:blocks[i]
                    exp[z + ispaces[j] - 1] = exp[z + iblocks[i] - 1]
                    exp[z + iblocks[i] - 1] = -1
                end
                spaces[j] -= blocks[i]
                ispaces[j] += blocks[i]
                break
            end
        end
    end
    checksum(exp)
end

function day09(input::String)
    input = @chain input begin
        chomp
        collect
        map(x -> x - '0', _)
    end

    exp::Vector{Int} = []
    space = false
    i = 0
    for n in input
        append!(exp, map(x -> space ? -1 : div(i, 2), 1:n))
        i += 1
        space= !space
    end

    p1 = part1(copy(exp))
    p2 = part2(input, copy(exp))

    @show (p1, p2)
end

day09(read_input(9))
