utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

inc(n::Int) = n + 1
dec(n::Int) = n - 1
id(n::Int) = n

function match(str::String, m::Vector{Vector{Char}}, i::Int, j::Int, fi, fj)
    for c in str
        try
            if m[i][j] != c
                return false
            end
            i = fi(i)
            j = fj(j)
        catch
            return false
        end
    end
    true
end

function day04(input::String)
    m = @chain input begin
        chomp
        split("\n")
        map(string, _)
        map(collect, _)
    end

    p1 = 0
    p2 = 0
    l = length(m)

    for i in 1:l
        for j in 1:l
            p1 += match("XMAS", m, i, j, id, inc)
            p1 += match("XMAS", m, i, j, id, dec)
            p1 += match("XMAS", m, i, j, inc, id)
            p1 += match("XMAS", m, i, j, dec, id)
            p1 += match("XMAS", m, i, j, inc, inc)
            p1 += match("XMAS", m, i, j, inc, dec)
            p1 += match("XMAS", m, i, j, dec, inc)
            p1 += match("XMAS", m, i, j, dec, dec)

            if match("MAS", m, i, j, inc, inc)
                p2 += match("MAS", m, i, j + 2, inc, dec)
                p2 += match("SAM", m, i, j + 2, inc, dec)
            end
            if match("SAM", m, i, j, inc, inc)
                p2 += match("MAS", m, i, j + 2, inc, dec)
                p2 += match("SAM", m, i, j + 2, inc, dec)
            end
        end
    end

    @show (p1, p2)
end

day04(read_input(4))
