"""
Finds an embedding for a string.

# Arguments
- `text::String`: Text for embedding.
"""
function get_embedding(text::String)
    embedder = pyimport("langchain.embeddings")
    embedding = embedder.OpenAIEmbeddings().embed_query(text)
    return pyconvert(Vector,embedding)
end

