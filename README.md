# AdventOfCode2024.jl
Advent of Code 2024 in Julia

Solutions for [Advent of Code](https://adventofcode.com), implemented in Julia.

## Days Solved

| Day | Part 1 | Part 2 |
|-----|--------|--------|
| 1   | YES    | YES    |
| 2   | YES    | YES    |
| 3   | YES    | YES    |
| 4   | YES    | YES    |
| 5   | YES    | YES    |
| 6   | YES    | YES    |
| 7   | YES    | YES    |
| 8   | YES    | YES    |
| 9   | YES    | YES    |
| 10  | YES    | YES    |
| 11  | YES    | YES    |
| 12  | YES    | YES    |
| 13  | YES    | YES    |
| 14  | YES    | YES    |
| 15  | YES    | YES    |
| 16  | YES    | YES    |
| 17  | YES    | YES    |
| 18  | YES    | YES    |
| 19  | YES    | YES    |
| 20  | YES    | YES    |
| 21  | YES    | YES    |
| 22  | YES    | YES    |
| 23  | YES    | YES    |
| 24  | YES    | NO     |
| 25  | YES    | NO     |

## Providing Inputs

To run the solutions, input files must be placed in the `input/` directory with the naming format `dayXX.txt`, where `XX` corresponds to the day number.

## How to Run

1. Navigate to the repository directory:

   ```bash
   cd path/to/repo
   julia
   ```

2. Run the desired day's solution using the Julia command-line interface:

   ```bash
   using Pkg
   Pkg.activate(".")
   Pkg.instantiate()
   include("src/dayXX.jl")
   ```
