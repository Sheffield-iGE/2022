### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ 370dae6a-3334-44e2-bda3-30878e970b92
# Import some helpful packages for loading and plotting data
using CSV, Dates, DataFrames, Gadfly, GLM, Statistics

# ╔═╡ dae44eef-71a6-4f67-b326-82bf8b392640
md"""
# What Is Julia?

Julia is a modern, open-source high-level programming language designed scientific computing. Though Julia was developed with this focus in mind, it remains a general-purpose language (closer to Python than R or Matlab) that can be used to solve a wide range of programming problems.

## Why Use Julia?
### The Two-Language Problem

High level languages like Python have become quite popular in scientific computing as their ease-of-use allows scientists to quickly prototype new programs and easily adapt them to changing requirements. Unfortunately, this comes at a bit of a cost as programs written in Python often struggle with performance. This means that, as the volume of data needing to be processed grows, Python programs must often be re-written a lower level language (like C/C++) to achieve an acceptable level of performance.

Once converted to a lower level language, however, updates to the program or the addition of new features becomes more difficult — new features may need to be prototyped again in Python before a *second rewrite* into a lower level language. Julia is positioned to solve this problem of continuous code re-writing and translation by providing a high-level language for developers, but also a high performance compiler capable of generating the optimised programs needed in scientific computing.

### Just How Fast?
![Julia Micro-Benchmarks](https://julialang.org/assets/images/benchmarks.svg)

### How Does Julia Compare to X?

The Julia documentation contains [several pages of information](https://docs.julialang.org/en/v1/manual/noteworthy-differences/) explaining the important differences between Julia and other popular languages like Python, R, MATLAB, C/C++, and Common Lisp.

To summarise where Julia draws it's inspiration from and how it improves on these other languages:
- Julia, like MATLAB and R, is a programming language developed with scientific computing in mind, but (unlike MATLAB) is open-source and (unlike R) is flexible enough to still allow for comfortable general-purpose programming (as in Python)
- Julia combines the high-level programming and easy syntax of Python, with the speed and efficiency of C/C++
- Julia tops this all off with powerful features like multiple dispatch and metaprogramming borrowed from Common Lisp, but without the comparatively arcane syntax

## Why *Not* Use Julia?

Though Julia is an excellent programming language well-posed to solve the two-language problem for most people, it's not for everyone. There remain a number of domains in which Julia as a language struggles:

- **Responsiveness ::** Julia's JIT compiler that manages to deliver such high-performance code in a dynamic language can also lead to large latency when new code is being run for the first time. It can still take tens of seconds to load a new package or even longer to plot some basic data. Julia isn't a language for embedded or realtime applications
- **Julia programs are for Julia users ::** Julia binaries are large (up to GBs) and difficult to share on their own. Source code is more commonly shared than compiled programs, so every user of your code will need their own Julia installation — something that isn't significantly different from other interpreted languages like MATLAB, R, and Python, but that is from C/C++. Julia is, generally speaking, a larger installation than R or Python, but still smaller than something like MATLAB
- **A relatively young language ::** Julia is still relatively new and there are some rough edges still. The ecosystem around the language is still changing quickly and up-to-date learning resources are comparitively hard to come by (particuarly when compared to a ubiquitious lanugage like Python)
- [**And more...**](https://viralinstruction.com/posts/badjulia/)
"""

# ╔═╡ 12ee4d87-511d-4da7-b8c9-af82d8a9bec8
md"""
# A Language for Science
## Interativity
### The Julia REPL

Julia comes with a [richly-featured Read-Evaluate-Print-Loop (REPL)](https://docs.julialang.org/en/v1/stdlib/REPL/) that can be used for interactive development. The REPL comes with several modes and distinctive features:

- Support for adding Unicode characters using LaTeX (try `\pi <tab>`)
- In-built package managment with Pkg mode (no `pip` needed!)
- Access to a Unix shell in Shell mode (don't need a second terminal window)
- A help mode for [accessing documentation](https://docs.julialang.org/en/v1/manual/documentation/) and code examples

### Pluto.jl

Pluto is an interactive notebook environment (like Jupyter notebook), but is reactive (cells are automaticaly re-run when their inputs change) and is written in and optimised for Julia.

This notebook is written in Pluto.jl and you can [play with Pluto yourself without installing on Binder](https://binder.plutojl.org/). The Pluto examples showcase many more advanced features than are used here!
"""

# ╔═╡ c5b6d22d-97a0-4133-823f-001bfe87948f
md"""
## Matematical Notation
### Unicode Support
"""

# ╔═╡ f7661da5-2764-41ac-8120-3476931b50a2
# Get the radius of a circle with an area of 20
begin
	A = 20
	√(A / π)
end

# ╔═╡ 670da1a9-11f9-441c-914e-41b401860782
md"""
### Literal Coefficients
"""

# ╔═╡ ee6d2afb-9c6d-4f72-911a-3bf0d882ceb5
x = 3

# ╔═╡ 81302e0b-6809-45e0-abcc-0a5bf974e680
# Clean polynomial functions
2x^2 - 3x + 1

# ╔═╡ a8b04a41-6fd7-49bf-9ee2-89aa3e80a912
# And exponential ones too
2^2x

# ╔═╡ 9e71b388-5ec3-4d30-aeec-e13d0f099a49
md"### Imaginary & Rational Numbers"

# ╔═╡ df2d292a-a9ef-4098-970b-1848153a09de
# Built-in support for imaginary numbers with `im`
im^2

# ╔═╡ 13159385-eb94-4f58-84a6-606539491dc1
2(1 - 1im)

# ╔═╡ 79d03cdb-21de-4479-85ef-4d462ed751e1
# And rational numbers with `//`
6//9

# ╔═╡ 2b647333-51c5-4fe1-8550-252d4381a291
-4//8

# ╔═╡ dc456b64-8508-4563-8f19-6d77da08ace4
5//-15

# ╔═╡ 87f43c73-22ad-4937-bde6-551b348319c0
-4//-12

# ╔═╡ 2a8a8302-c624-456f-9e5f-009cf6f8e7eb
3//4 * 5//6 # 15//24

# ╔═╡ dde9fcc5-05f9-4edb-bfb1-71b5ebe7739c
md"### [Working With Matrices](https://docs.julialang.org/en/v1/manual/arrays/#man-array-literals)"

# ╔═╡ ab9ed3aa-f81b-48fc-ba9f-3715e25602ff
# Support for matrix literals
Hm = [1 1; 1 -1]

# ╔═╡ 49cfc630-d201-454e-be5d-3c4ac969228c
# And operations
H = 1/√2 * Hm

# ╔═╡ 2d11381c-38bd-47e6-adf3-35abbe2a16ae
# Including matrix multiplication
plus = 1/√2 * [1 1]'

# ╔═╡ aab161b8-b2fe-46e5-b307-1131829355cc
round.(H * plus)

# ╔═╡ daba8fb3-3e65-4a41-8eb5-f10be4d9691e
# Note the use of the `.` for broadcasting functions over a tensor
sqrt.(1:4)

# ╔═╡ 2750be83-4846-47b8-880f-385bdcc0bce4
md"""
### Scientific Packages

The Julia ecosystem contains a robust set of packages for scientific computing. Today we'll be using some of the packages in [StatsKit](https://github.com/JuliaStats/StatsKit.jl) — particularly [Dataframes.jl](https://dataframes.juliadata.org/stable/) and [GLM.jl](https://juliastats.org/GLM.jl/stable/).

# Growth Curve Analysis in Julia
"""

# ╔═╡ 96b5af19-0d96-4cf4-bb4d-48cf6aa44c65
# Load CSV into a DataFrame
df = DataFrame(CSV.File("Growth Curve Data.csv"))

# ╔═╡ 15ed8972-899d-4c23-b301-940fe4063a90
# Convert to long format
ldf = stack(df, 2:26, variable_name=:Replicate, value_name=:OD) |> dropmissing

# ╔═╡ b2f6bdf0-fe8a-4444-91c9-69a8029f6430
# Normalise times and convert to minutes
start = ldf[1, :Time]

# ╔═╡ 3ad03034-36ed-4ea1-939d-4a74e2fd5cbd
pdf = transform(ldf, :Time => ByRow(t -> Dates.value(Minute(t - start))) => :Time)

# ╔═╡ ee0b9524-5c79-4048-96b8-527a54712629
md"## Growth Curve Data

Given that OD is proportional to cell count (when properly diluted so that readings don't exceed 0.6), it can be used to track the growth of cells.

On a linear scale, this growth curve is an exponential, but be later made linear by applying a logarithmic transformation.
"

# ╔═╡ 55b510e1-0b96-42ca-b940-0705f329d058
# Construct a line-scatter plot, grouping by biological replicate
plot(pdf, x=:Time, y=:OD, color=:Replicate,
     Guide.xlabel("Minutes"), Guide.ylabel("OD₆₀₀"),
     Guide.title("<i>V. Natriegens</i> Growth Curves"))

# ╔═╡ 54eeb0d4-1058-4d2c-9093-d437132b5f86
# Replot, but on a log-scale so that we can pick out the exponential growth region
plot(pdf, x=:Time, y=:OD, color=:Replicate, Scale.y_log2,
     Guide.xlabel("Minutes"), Guide.ylabel("OD₆₀₀"),
     Guide.title("<i>V. Natriegens</i> Growth Curves"))

# ╔═╡ dc9c6b75-860d-458f-8e12-849378e40a0d
# Group by replicate / media
gdf = groupby(pdf, :Replicate)

# ╔═╡ ed22a327-aba2-421b-9dfb-b2b30ba01e9c
begin
	# Pick a replicate to zero in on
	curve = 9
	# Replot, but focusing on a single curve
	plot(gdf[curve], x=:Time, y=:OD, color=:Replicate, Scale.y_log2,
         Guide.xlabel("Minutes"), Guide.ylabel("OD₆₀₀"),
         Guide.title("<i>V. Natriegens</i> Growth Curves"))
end

# ╔═╡ f4a76b84-f624-4c9d-ac4a-3ada4e96a721
# Trim the data to take a closer look at log-phase
logdf = filter(:Time => t -> 20 <= t <= 100, gdf[curve])

# ╔═╡ 542d02b1-51f2-40f2-bbaa-94c758e4406a
# Log-transform the OD data
transform!(logdf, :OD => ByRow(log2) => :OD)

# ╔═╡ 8080c6da-094e-41e7-bbd4-b1b22cb00bb9
# Perform and ordinary least-squares regression for a linear model
ols = lm(@formula(OD ~ Time), logdf)

# ╔═╡ 60e72978-49e7-4773-bba1-a6c28be99eeb
# Insert a new column into our dataframe representing the model predictions
logdf[!,:Model] = predict(ols)

# ╔═╡ abf42aad-85fc-4946-9dd3-0a81b41e9270
# And then plot it on a log-scale
plot(logdf, x=:Time, y=:OD, color=:Replicate, Geom.point,
     Guide.xlabel("Minutes"), Guide.ylabel("log₂(OD₆₀₀)"),
     Guide.title("<i>V. Natriegens</i> Growth Curves"),
     layer(x=:Time, y=:Model, Geom.line))

# ╔═╡ c975c4b0-93d9-4cc9-b5e0-070b6bec3d04
md"## Calculating Doubling-Time From Our Model

We can start with a fundamental equation that models the growth of microbes undergoing binary fission:

$N = N_0 2^{\frac{t}{g}}$

Where $N$ is the current number of cells, $N_0$ is the initial number of cells, $t$ is time, and $g$ is generation or doubling-time. We want to rearrange this equation to fit the model `OD ~ Time` after calculating the $\log_2$ of all ODs.

Let's start by applying the $\log_2$ to both sides of the equation:

$\log_2{N} = \log_2{N_0} + \frac{t}{g}$

Ignoring the intercept and separating terms, we get an expression that matches our model:

$\log_2{N} = \frac{1}{g} t$

Therefore we can conclude that $g$ is equal to the reciprocal of our regression gradient."

# ╔═╡ 290a93be-92f8-4a56-88b9-cfff40c088db
begin
	# Calculate doubling-time
	g = 1/coef(ols)[2]
	# Format it into a nice string
	md"The doubing time was ~$(round(g, sigdigits=3)) minutes"
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
GLM = "38e38edf-8417-5370-95a0-9cbb8c7f171a"
Gadfly = "c91e804a-d5a3-530f-b6f0-dfbca275c004"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
CSV = "~0.10.4"
DataFrames = "~1.3.5"
GLM = "~1.8.0"
Gadfly = "~1.3.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.1"
manifest_format = "2.0"
project_hash = "98da566ac90895aecbefcf525fc600789d829b04"

[[deps.AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra"]
git-tree-sha1 = "69f7020bd72f069c219b5e8c236c1fa90d2cb409"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.2.1"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "195c5505521008abea5aee4f96930717958eac6f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.4.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings"]
git-tree-sha1 = "873fb188a4b9d76549b81465b1f75c82aaf59238"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.4"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "5f5a975d996026a8dd877c35fe26a7b8179c02ba"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.6"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "dc4405cee4b2fe9e1108caec2d760b7ea758eca2"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.5"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "38f7a08f19d8810338d4f5085211c7dfa5d5bdd8"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.4"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "5856d3031cdb1f3b2b6340dfdc66b6d9a149a374"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.2.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Compose]]
deps = ["Base64", "Colors", "DataStructures", "Dates", "IterTools", "JSON", "LinearAlgebra", "Measures", "Printf", "Random", "Requires", "Statistics", "UUIDs"]
git-tree-sha1 = "d853e57661ba3a57abcdaa201f4c9917a93487a2"
uuid = "a81c6b42-2e10-5240-aca2-a61377ecd94b"
version = "0.9.4"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.CoupledFields]]
deps = ["LinearAlgebra", "Statistics", "StatsBase"]
git-tree-sha1 = "6c9671364c68c1158ac2524ac881536195b7e7bc"
uuid = "7ad07ef1-bdf2-5661-9d2b-286fd4296dac"
version = "0.2.0"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "fb5f5316dd3fd4c5e7c30a24d50643b73e37cd40"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.10.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "6bce52b2060598d8caaed807ec6d6da2a1de949e"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.5"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "3258d0659f812acde79e8a74b11f17ac06d0ca04"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.7"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "34a557ce10eb2d9142f4ef60726b4f17c1c30941"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.73"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "90630efff0894f8142308e334473eba54c433549"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.5.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "e27c4ebe80e8699540f2d6c805cc12203b614f12"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.20"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "87519eb762f85534445f5cda35be12e32759ee14"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.4"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLM]]
deps = ["Distributions", "LinearAlgebra", "Printf", "Reexport", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "StatsModels"]
git-tree-sha1 = "039118892476c2bf045a43b88fcb75ed566000ff"
uuid = "38e38edf-8417-5370-95a0-9cbb8c7f171a"
version = "1.8.0"

[[deps.Gadfly]]
deps = ["Base64", "CategoricalArrays", "Colors", "Compose", "Contour", "CoupledFields", "DataAPI", "DataStructures", "Dates", "Distributions", "DocStringExtensions", "Hexagons", "IndirectArrays", "IterTools", "JSON", "Juno", "KernelDensity", "LinearAlgebra", "Loess", "Measures", "Printf", "REPL", "Random", "Requires", "Showoff", "Statistics"]
git-tree-sha1 = "13b402ae74c0558a83c02daa2f3314ddb2d515d3"
uuid = "c91e804a-d5a3-530f-b6f0-dfbca275c004"
version = "1.3.4"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.Hexagons]]
deps = ["Test"]
git-tree-sha1 = "de4a6f9e7c4710ced6838ca906f81905f7385fd6"
uuid = "a1b4810d-1bce-5fbd-ac56-80944d57a21f"
version = "0.2.0"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions", "Test"]
git-tree-sha1 = "709d864e3ed6e3545230601f94e11ebc65994641"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.11"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "d19f9edd8c34760dca2de2b503f969d8700ed288"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.1.4"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "f67b55b6447d36733596aea445a9f119e83498b6"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.5"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "b3364212fb5d870f724876ffcd34dd8ec6d98918"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.7"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.Juno]]
deps = ["Base64", "Logging", "Media", "Profile"]
git-tree-sha1 = "07cb43290a840908a771552911a6274bc6c072c7"
uuid = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
version = "0.8.4"

[[deps.KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "9816b296736292a80b9a3200eb7fbb57aaa3917a"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.5"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Loess]]
deps = ["Distances", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "46efcea75c890e5d820e670516dc156689851722"
uuid = "4345ca2d-374a-55d4-8d30-97f9976e7612"
version = "0.5.4"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "94d9c52ca447e23eac0c0f074effbcd38830deb5"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.18"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "41d162ae9c868218b1f3fe78cba878aa348c2d26"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2022.1.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Media]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "75a54abd10709c01f1b86b84ec225d26e840ed58"
uuid = "e89f7d12-3494-54d1-8411-f7d8b9ae1f27"
version = "0.5.0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "a7c3d1da1189a1c2fe843a3bfa04d18d20eb3211"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "1ea784113a6aa054c5ebd95945fa5e52c2f378e7"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.7"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "cf494dca75a69712a72b80bc48f59dcf3dea63ec"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.16"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a6062fe4063cdafe78f4a0a81cfffb89721b30e7"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "3c009334f45dfd546a16a57960a821a1a023d241"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.5.0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "dc84268fe0e3335a62e315a3a7cf2afa7178a734"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.3"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "db8481cf5d6278a121184809e9eb1628943c7704"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.13"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.ShiftedArrays]]
git-tree-sha1 = "503688b59397b3307443af35cd953a13e8005c16"
uuid = "1277b4bf-5013-50f5-be3d-901d8477a67a"
version = "2.0.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "d75bda01f8c31ebb72df80a46c88b25d1c79c56d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.7"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "efa8acd030667776248eabb054b1836ac81d92f0"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.7"

[[deps.StaticArraysCore]]
git-tree-sha1 = "ec2bd695e905a3c755b33026954b119ea17f2d22"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.3.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "5783b877201a82fc0014cbf381e7e6eb130473a4"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.0.1"

[[deps.StatsModels]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Printf", "REPL", "ShiftedArrays", "SparseArrays", "StatsBase", "StatsFuns", "Tables"]
git-tree-sha1 = "2bf47edcd9156b6c2954d6687b565f221f6500ae"
uuid = "3eaba693-59b7-5ba5-a881-562e759f1c8d"
version = "0.6.32"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "7149a60b01bf58787a1b83dad93f90d4b9afbe5d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.8.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "8a75929dcd3c38611db2f8d08546decb514fcadf"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.9"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─dae44eef-71a6-4f67-b326-82bf8b392640
# ╟─12ee4d87-511d-4da7-b8c9-af82d8a9bec8
# ╟─c5b6d22d-97a0-4133-823f-001bfe87948f
# ╠═f7661da5-2764-41ac-8120-3476931b50a2
# ╟─670da1a9-11f9-441c-914e-41b401860782
# ╠═ee6d2afb-9c6d-4f72-911a-3bf0d882ceb5
# ╠═81302e0b-6809-45e0-abcc-0a5bf974e680
# ╠═a8b04a41-6fd7-49bf-9ee2-89aa3e80a912
# ╟─9e71b388-5ec3-4d30-aeec-e13d0f099a49
# ╠═df2d292a-a9ef-4098-970b-1848153a09de
# ╠═13159385-eb94-4f58-84a6-606539491dc1
# ╠═79d03cdb-21de-4479-85ef-4d462ed751e1
# ╠═2b647333-51c5-4fe1-8550-252d4381a291
# ╠═dc456b64-8508-4563-8f19-6d77da08ace4
# ╠═87f43c73-22ad-4937-bde6-551b348319c0
# ╠═2a8a8302-c624-456f-9e5f-009cf6f8e7eb
# ╟─dde9fcc5-05f9-4edb-bfb1-71b5ebe7739c
# ╠═ab9ed3aa-f81b-48fc-ba9f-3715e25602ff
# ╠═49cfc630-d201-454e-be5d-3c4ac969228c
# ╠═2d11381c-38bd-47e6-adf3-35abbe2a16ae
# ╠═aab161b8-b2fe-46e5-b307-1131829355cc
# ╠═daba8fb3-3e65-4a41-8eb5-f10be4d9691e
# ╟─2750be83-4846-47b8-880f-385bdcc0bce4
# ╠═370dae6a-3334-44e2-bda3-30878e970b92
# ╠═96b5af19-0d96-4cf4-bb4d-48cf6aa44c65
# ╠═15ed8972-899d-4c23-b301-940fe4063a90
# ╠═b2f6bdf0-fe8a-4444-91c9-69a8029f6430
# ╠═3ad03034-36ed-4ea1-939d-4a74e2fd5cbd
# ╟─ee0b9524-5c79-4048-96b8-527a54712629
# ╠═55b510e1-0b96-42ca-b940-0705f329d058
# ╠═54eeb0d4-1058-4d2c-9093-d437132b5f86
# ╠═dc9c6b75-860d-458f-8e12-849378e40a0d
# ╠═ed22a327-aba2-421b-9dfb-b2b30ba01e9c
# ╠═f4a76b84-f624-4c9d-ac4a-3ada4e96a721
# ╠═542d02b1-51f2-40f2-bbaa-94c758e4406a
# ╠═8080c6da-094e-41e7-bbd4-b1b22cb00bb9
# ╠═60e72978-49e7-4773-bba1-a6c28be99eeb
# ╠═abf42aad-85fc-4946-9dd3-0a81b41e9270
# ╟─c975c4b0-93d9-4cc9-b5e0-070b6bec3d04
# ╠═290a93be-92f8-4a56-88b9-cfff40c088db
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
