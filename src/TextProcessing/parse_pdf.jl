"""
Loads PDF file to text and splits it into chunks.

# Arguments
- `path::String`: File path to the PDF.
"""
function parse_pdf(path::String)
    unstructured = pyimport("langchain.document_loaders")
    doc = unstructured.UnstructuredFileLoader(path)
    text = doc.load()
    text = text[0].page_content
    splitter = pyimport("langchain.text_splitter")
    text_splitter = splitter.RecursiveCharacterTextSplitter(
        # Set a really small chunk size, just to show.
        chunk_size = 1000,
        chunk_overlap  = 100,
        length_function = length,
        add_start_index = true,
    )
    texts = pyconvert.(Vector, text_splitter.create_documents([pystr(text)]))

    return texts
end

