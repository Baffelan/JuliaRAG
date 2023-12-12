"""
Creates and executes a query to an LLM.

# Arguments
- `query::String`: The question and context to be answered in the query.
- `search_space::Tuple`: Vector space and associated chunkised text.
"""
function query_llm(query::String, search_space::Tuple)
    query_embedding = get_embedding(query)

    idx, _ = knn(search_space[1], query_embedding, 3)
    relevant_chunks = search_space[2][idx]

    relevant_text = join(relevant_chunks, "\n")

    @pyexec """import sys
    # caution: path[0] is reserved for script path (or '' in REPL)
    sys.path.insert(1, './src')
    """
    model_setup = pyimport("model_setup")
    model = model_setup.setup_chat_model(query, "gpt-4")
    model(PyDict(Dict(pystr("question")=> pystr(relevant_text))))
end
