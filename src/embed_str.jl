"""
Embeds a text in RAM for vector searching.

# Arguments
- `text::String`: Text to be embedded
- `chunk_size::Int`: The number of characters for each chunk.
- `overlap::Int`: The number of characters of overlap of the chunks.
"""
function embed_str(text::String, chunk_size::Int, overlap::Int)
    splitter = pyimport("langchain.text_splitter")
    text_splitter = splitter.RecursiveCharacterTextSplitter(
        # Set a really small chunk size, just to show.
        chunk_size = chunk_size,
        chunk_overlap  = overlap,
        length_function = length,
        add_start_index = true,
    )
    texts = pyconvert.(Vector, text_splitter.create_documents([pystr(text)]))

    strings = getindex.(getindex.(texts,1),2)
    embeddings = get_embedding_openai.(strings) # For now change this function to switch embedding LLM TODO: add argument for it
    
    search_space = make_vector_space(strings, embeddings)
end