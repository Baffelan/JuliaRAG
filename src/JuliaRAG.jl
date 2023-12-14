module JuliaRAG
    using PythonCall
    using CondaPkg
    using Distances
    using NearestNeighbors

    const pyglobals = PyDict()
    
    include("TextProcessing/get_embedding.jl")
    include("TextProcessing/parse_pdf.jl")

    
    include("embed_pdf.jl")
    include("embed_str.jl")
    include("make_vector_space.jl")
    include("query_llm.jl")
    include("install_python_packs.jl")

    export embed_pdf
    export embed_str
    export query_llm
    export install_python_packs

end



