"""
Make and stores embeddings in a vector space for efficient searching.

# Arguments
- `strings::Vector{String}`
- `embeddings::Vector{Vector{Float64}}`
"""
function make_vector_space(strings::Vector{String}, embeddings::Vector{Vector{Float64}})
    balltree = BallTree(hcat(embeddings...); reorder = false)
    return (balltree, strings)
end

