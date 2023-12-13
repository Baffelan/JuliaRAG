"""
Embeds a pdf in RAM for vector searching.

# Arguments
- `path::String`: Path to the pdf being embedded
"""
function embed_pdf(path::String)
    texts = parse_pdf(path)
    strings = getindex.(getindex.(texts,1),2)
    embeddings = get_embedding.(strings)
    
    search_space = make_vector_space(strings, embeddings)
end