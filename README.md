# JuliaRAG

[![Build Status](https://github.com/StirlingSmith/JuliaRAG.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/StirlingSmith/JuliaRAG.jl/actions/workflows/CI.yml?query=branch%3Amain)

# Example
```julia
using JuliaRAG # Available through Baito registry
using PythonCall
emb_space = embed_pdf("apple_k8_buyback1.pdf")

response = query_llm("""You are an assistant who helps extract information from documents. You will get a document, this document contains information about stock issuances and buybacks. You will answer the following questions about the document. When answering you will keep all operations, dates, and prices. Do NOT give date ranges. Start each answer on a new line.

The columns of the output will have the headings: TitleCompany, CompanySold, NumberOfStocks, Date, Operation, TotalCost, CostPerShare, Currency. 

Each operation mentioned will have its own row. If a company both buys and sells stocks, have these on DIFFERENT rows.

Each value should be separated by a semicolon, NOT a comma.

ONLY include values that exist in the document. Do NOT calculate total cost.

Give back ONLY the semicolon separated value file with column headers and nothing more.

What is the name of the company that is in the title of this document?
What company stock was issued or bought back?
How many stocks?
What date(s) did the company issue or buy back stocks?
What operation did the company execute?
What was the total cost?
What was the cost per share?
What currency is being used?
""", emb_space, 5)

pyconvert(String, response["text"])
```