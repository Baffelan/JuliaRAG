"""
Creates and executes a query to an LLM.

# Arguments
- `query::String`: The question and context to be answered in the query.
- `search_space::Tuple`: Vector space and associated chunkised text.
- `k::Int`: The number of nearest neighbours required
"""
function query_llm(query::String, search_space::Tuple, k::Int)
    tiktoken = pyimport("tiktoken")
    query_embedding = get_embedding_hf(query)

    idx, _ = knn(search_space[1], query_embedding, k)
    relevant_chunks = search_space[2][idx]

    relevant_text = join(relevant_chunks, "\n")
    path = match(r"^(.*[\\\/])[^\\\/]*$", pathof(JuliaRAG))[1]
    @pyexec (path=path)=>"""import sys
    # caution: path[0] is reserved for script path (or '' in REPL)
    sys.path.insert(1, path)
    import model_setup
    model_setup
    """ => model_setup
    #model_setup = pyimport("model_setup")
    model = model_setup.setup_chat_model(query, "gpt-4-1106-preview")
    
    output = model(PyDict(Dict(pystr("question")=> pystr(relevant_text))))
    println(keys(pyconvert(Dict,output)))
    enc = tiktoken.encoding_for_model("gpt-4-1106-preview")
    println("Input is ",length(enc.encode(output["question"]))," tokens.")
    response = pyconvert(String, output["text"])
    println("Output is ",length(enc.encode(output["text"]))," tokens.")


    CSV.write("token_use.csv", Tables.table(["input" length(enc.encode(output["question"])) "gpt-4-1106-preview"]), append=true)
    CSV.write("token_use.csv", Tables.table(["output" length(enc.encode(output["text"])) "gpt-4-1106-preview"]), append=true)


    return response, relevant_chunks
end
# @pyexec """import sys
# # caution: path[0] is reserved for script path (or '' in REPL)
# sys.path.insert(1, './src')
# import os
# from os import getcwd
# import os

# # #abspath = os.path.abspath(__file__)
# # dname = os.path.dirname(abspath)
# # os.chdir(dname)
# print(os.path.realpath())
# print(getcwd())
# import model_setup
# model_setup
# """ => model_setup
# Base.source_path()