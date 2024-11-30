module AdventOfCode2024

using ArgParse
using Printf

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "day"
        help = "Day to run"
        required = true
        arg_type = Int
    end

    return parse_args(s)
end

function main()
    args = parse_commandline()
    day = args["day"]
    filename = joinpath(@__DIR__, @sprintf("day%02d.jl", day))
    include(filename)
end

main()

end # module AdventOfCode2024
