utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain
using IterTools

function firstindex(sub::Vector{Int}, changes::Vector{Int})
    for i in 1:length(changes) - 3
        if sub == changes[i:i + 3]
            return i + 4
        end
    end
    0
end

function next(n::Int)
    m = n * 64
    n = n ⊻ m
    n = n % 16777216
    m = div(n, 32)
    n = n ⊻ m
    n = n % 16777216
    m = n * 2048
    n = n ⊻ m
    n = n % 16777216
end

function prices(n::Int)
    v = Vector{Int}()
    for _ in 1:2000
        push!(v, n % 10)
        n = next(n)
    end
    v
end

function solve1(n::Int)
    for _ in 1:2000
        n = next(n)
    end
    n
end

function day22(input::String)
    input = @chain input begin
        chomp
        split("\n")
        map(parse_int, _)
    end

    p1 = 0
    for n in input
        p1 += solve1(n)
    end

    p2 = 0
    p = map(prices, input)
    c = map(l -> map(p -> p[2] - p[1], IterTools.partition(l, 2, 1)), p)
    visited = Set{Vector{Int}}()
    for i in 1:length(input)
        subs = map(collect, IterTools.partition(c[i], 4, 1))
        for sub in subs
            if !(sub in visited)
                push!(visited, sub)
                m = 0
                for j in 1:length(input)
                    index = firstindex(sub, c[j])
                    m += index == 0 ? 0 : p[j][index]
                end
                p2 = max(p2, m)
            end
        end
    end

    @show (p1, p2)
end

day22(read_input(22))
