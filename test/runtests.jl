using Coordinates
using Test
using Aqua

@testset "Coordinates.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(Coordinates)
    end
    # Write your tests here.
end
