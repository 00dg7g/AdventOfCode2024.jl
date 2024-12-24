utils = joinpath(@__DIR__, "utils.jl")
include(utils)

using Chain

function number(wires::Dict{String, Bool}, prefix::String)
    ans = 0
    n = 0
    while true
        try
            ans += wires[prefix * lpad(n, 2, "0")] << n
        catch
            break
        end
        n += 1
    end
    ans
end

function update!(wires::Dict{String, Bool}, connections::Vector{Vector{String}})
    for _ in 1:length(connections)
        for (x1, op, x2, x3) in connections
            try
                value = false
                if op == "AND"
                    value = wires[x1] && wires[x2]
                elseif op == "OR"
                    value = wires[x1] || wires[x2]
                else
                    value = wires[x1] ⊻ wires[x2]
                end
                wires[x3] = value
            catch
            end
        end
    end
end

function swap!(connections::Vector{Vector{String}}, x::Int, y::Int)
    tmp = connections[x][4]
    connections[x][4] = connections[y][4]
    connections[y][4] = tmp
end

function day24(input::String)
    input = split(chomp(input), "\n\n")
    init = @chain input[1] begin
        split("\n")
        map(x -> split(x, ": "), _)
        map(x -> (x[1], x[2] == "1"), _)
    end
    connections = @chain input[2] begin
        replace("-> "=>"")
        split("\n")
        map(x -> split(x, " "), _)
        map(x -> map(string, x), _)
    end
    wires = Dict{String, Bool}()

    for (name, value) in init
        wires[name] = value
    end

    update!(wires, connections)
    p1 = number(wires, "z")

    @show (p1, nothing)
end

day24(read_input(24))
