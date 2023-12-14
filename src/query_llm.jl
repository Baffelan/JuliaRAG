"""
Creates and executes a query to an LLM.

# Arguments
- `query::String`: The question and context to be answered in the query.
- `search_space::Tuple`: Vector space and associated chunkised text.
- `k::Int`: The number of nearest neighbours required
"""
function query_llm(query::String, search_space::Tuple, k::Int)
    query_embedding = get_embedding(query)

    idx, _ = knn(search_space[1], query_embedding, k)
    relevant_chunks = search_space[2][idx]

    relevant_text = join(relevant_chunks, "\n")
    path = match(r"^(.*[\\\/])[^\\\/]*$", pathof(JuliaRAG))[1]
    @pyexec (path=path)=>"""import sys
    # caution: path[0] is reserved for script path (or '' in REPL)
    sys.path.insert(1, path)

    print(path)
    import model_setup
    model_setup
    """ => model_setup
    #model_setup = pyimport("model_setup")
    model = model_setup.setup_chat_model(query, "gpt-4")
    response = pyconvert(String, model(PyDict(Dict(pystr("question")=> pystr(relevant_text))))["text"])

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