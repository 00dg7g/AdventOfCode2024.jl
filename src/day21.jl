utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain
using Memoize

numeric = Dict{Char, Tuple{Int, Int}}(
    '1'=>(3, 1),
    '2'=>(3, 2),
    '3'=>(3, 3),
    '4'=>(2, 1),
    '5'=>(2, 2),
    '6'=>(2, 3),
    '7'=>(1, 1),
    '8'=>(1, 2),
    '9'=>(1, 3),
    '0'=>(4, 2),
    'A'=>(4, 3)
)

directional = Dict{Char, Tuple{Int, Int}}(
    '^'=>(1, 2),
    'A'=>(1, 3),
    '<'=>(2, 1),
    'v'=>(2, 2),
    '>'=>(2, 3)
)

@memoize function control(first::Bool, code::String, n::Int)
    i, j = first ? (4, 3) : (1, 3)
    i1, j1, h1, k1 = first ? (4, 1, 4, 1) : (1, 1, 1, 1)
    i2, j2 = first ? (4, 3) : (1, 3)
    l = 0
    for c in code
        h, k = first ? numeric[c] : directional[c]
        right = k - j
        down = h - i

        v = Vector{Int}()
        if i != i1 || k != k1
            s = (right > 0 ? ">" : "<") ^ abs(right)
            s *= (down > 0 ? "v" : "^") ^ abs(down)
            s *= "A"
            push!(v, n == 0 ? length(s) : control(false, s, n - 1))
        end
        if j != j1 || h != h1
            s = (down > 0 ? "v" : "^") ^ abs(down)
            s *= (right > 0 ? ">" : "<") ^ abs(right)
            s *= "A"
            push!(v, n == 0 ? length(s) : control(false, s, n - 1))
        end

        l += minimum(v)
        i, j = h, k
    end
    l
end

function day21(input::String)
    input = @chain input begin
        chomp
        split("\n")
        map(string, _)
    end

    p1 = 0
    p2 = 0
    for code in input
        num = code |> chop |> parse_int
        p1 += control(true, code, 2) * num
        p2 += control(true, code, 25) * num
    end

    @show (p1, p2)
end

day21(read_input(21))
