module JuliaRAG
    using PythonCall
    using CondaPkg
    using Distances
    using NearestNeighbors

    const pyglobals = PyDict()
    
    include("TextProcessing/get_embedding.jl")
    include("TextProcessing/parse_pdf.jl")

    include("embed_pdf.jl")
    include("make_vector_space.jl")
    include("query_llm.jl")

    export embed_pdf
    export query_llm

end



