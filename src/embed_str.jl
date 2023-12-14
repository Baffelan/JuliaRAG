"""
Embeds a text in RAM for vector searching.

# Arguments
- `text::String`: Text to be embedded
"""
function embed_str(text::String)
    splitter = pyimport("langchain.text_splitter")
    text_splitter = splitter.RecursiveCharacterTextSplitter(
        # Set a really small chunk size, just to show.
        chunk_size = 1000,
        chunk_overlap  = 100,
        length_function = length,
        add_start_index = true,
    )
    texts = pyconvert.(Vector, text_splitter.create_documents([pystr(text)]))

    strings = getindex.(getindex.(texts,1),2)
    embeddings = get_embedding_hf.(strings) # For now change this function to switch embedding LLM TODO: add argument for it
    
    search_space = make_vector_space(strings, embeddings)
end