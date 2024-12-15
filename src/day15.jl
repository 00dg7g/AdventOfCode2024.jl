utils = joinpath(@__DIR__, "utils.jl")
include(utils)

dirs = Dict{Char, Tuple{Int, Int}}(
    '>'=>(0, 1),
    '<'=>(0, -1),
    'v'=>(1, 0),
    '^'=>(-1, 0)
)

double = Dict{Char, Tuple{Char, Char}}(
    '#'=>('#', '#'),
    'O'=>('[', ']'),
    '.'=>('.', '.'),
    '@'=>('@', '.')
)

answer(grid::Vector{Vector{Char}}, c::Char) =
    sum(map(p -> 100(p[1] - 1) + p[2] - 1, find(grid, c)))

function trymove(grid::Vector{Vector{Char}}, i::Int, j::Int, move::Char)
    h, k = (i, j) .+ dirs[move]
    if grid[h][k] == '.'
        return true
    end
    if grid[h][k] == '#'
        return false
    end
    if grid[h][k] == '['
        return trymove(grid, h, k, move) && trymove(grid, h, k + 1, move)
    end
    # grid[h][k] == ']'
    return trymove(grid, h, k, move) && trymove(grid, h, k - 1, move)
end

function attempt(grid::Vector{Vector{Char}}, i::Int, j::Int, move::Char)
    h, k = (i, j) .+ dirs[move]
    if grid[h][k] == 'O'
        attempt(grid, h, k, move)
    elseif move == '<' || move == '>'
        if grid[h][k] == '[' || grid[h][k] == ']'
            attempt(grid, h, k, move)
        end
    else                        # move == 'v' || move == '^'
        if grid[h][k] == '['
            if trymove(grid, h, k, move) && trymove(grid, h, k + 1, move)
                attempt(grid, h, k, move)
                attempt(grid, h, k + 1, move)
            end
        elseif grid[h][k] == ']'
            if trymove(grid, h, k, move) && trymove(grid, h, k - 1, move)
                attempt(grid, h, k, move)
                attempt(grid, h, k - 1, move)
            end
        end
    end
    if grid[h][k] == '.'
        grid[h][k] = grid[i][j]
        grid[i][j] = '.'
        return h, k
    end
    return i, j
end

function day15(input::String)
    input = split(input, "\n\n")
    grid1 = map(collect, split(input[1], "\n"))
    moves = collect(replace(input[2], "\n"=>""))

    grid2 = map(collect, map(r -> Iterators.flatmap(c -> double[c], r), grid1))
    i1, j1 = find(grid1, '@')[1]
    i2, j2 = find(grid2, '@')[1]
    for move in moves
        i1, j1 = attempt(grid1, i1, j1, move)
        i2, j2 = attempt(grid2, i2, j2, move)
    end
    p1 = answer(grid1, 'O')
    p2 = answer(grid2, '[')

    @show (p1, p2)
end

day15(read_input(15))
