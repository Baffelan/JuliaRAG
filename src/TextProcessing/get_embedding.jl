"""
Finds an embedding for a string.

# Arguments
- `text::String`: Text for embedding.
"""
function get_embedding_openai(text::String)
    println("ping")
    embedder = pyimport("langchain.embeddings")
    embedding = embedder.OpenAIEmbeddings().embed_query(text)
    return pyconvert(Vector,embedding)
end

"""
Finds an embedding for a string.

# Arguments
- `text::String`: Text for embedding.
"""
function get_embedding_hf(text::String)
    println("pong")
    embedder = pyimport("langchain.embeddings")
    model_name = "BAAI/bge-small-en"
    model_kwargs = Dict("device"=> "cpu")
    encode_kwargs = Dict("normalize_embeddings"=> true)

    embedding = embedder.HuggingFaceBgeEmbeddings(model_name=model_name, model_kwargs=model_kwargs, encode_kwargs=encode_kwargs).embed_query(text)

    return pyconvert(Vector,embedding)
end

