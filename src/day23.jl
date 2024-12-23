utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain
using DataStructures

function bfs(g::Dict{String, Set{String}}, start::String, depth::Int, p1::Bool)
    q = Queue{Tuple{Vector{String}, Int}}()
    visited = Set{String}()
    curr, d = [start], 0
    while d < depth
        for next in g[curr[end]]
            if !(next in curr) || next == start
                enqueue!(q, (vcat(curr, next), d + 1))
            end
        end
        curr, d = dequeue!(q)
    end
    Set(map(Set, filter(v -> v[end] == start, map(p -> p[1], q))))
end

function day23(input::String)
    input = @chain input begin
        chomp
        split("\n")
        map(x -> split(x, "-"), _)
        map(x -> map(string, x), _)
    end

    nodes = Set{String}()
    for (n1, n2) in input
        push!(nodes, n1)
        push!(nodes, n2)
    end

    g = Dict{String, Set{String}}()
    for (n1, n2) in input
        if !(n1 in keys(g))
            g[n1] = Set{String}()
        end
        if !(n2 in keys(g))
            g[n2] = Set{String}()
        end
        push!(g[n1], n2)
        push!(g[n2], n1)
    end

    p1 = @chain collect(nodes) begin
        filter(node -> node[1] == 't', _)
        map(node -> bfs(g, node, 3, true), _)
        Iterators.flatten
        collect
        unique
        length
    end

    maxclique = Set{String}()
    for node in nodes
        clique = Vector{String}()
        push!(clique, node)
        maximal = false
        while !maximal
            maximal = true
            for neighbor in foldl(union, map(n -> g[n], clique))
                if issubset(clique, g[neighbor])
                    maximal = false
                    push!(clique, neighbor)
                end
            end
        end
        if length(maxclique) < length(clique)
            maxclique = clique
        end
    end
    p2 = chop(foldl(*, map(s -> s * ",", sort(maxclique))))

    @show (p1, p2)
end

day23(read_input(23))
