function install_python_packs()
    CondaPkg.add("langchain")
    CondaPkg.add("pdf2image")
    CondaPkg.add("pdfminer.six")
    CondaPkg.add("pikepdf")
    CondaPkg.add("cmake")
    CondaPkg.add("chromadb")
    CondaPkg.add("openai")
    @pyexec """
    import os
    os.system("pip install unstructured")
    os.system("pip install opencv-python")
    os.system("pip install pandas")
    os.system("pip install unstructured-pytesseract")
    os.system("pip install unstructured-inference")
    os.system("pip install --upgrade openai==0.28.1") # v1.x.x not working at time of running so rolling back openai
    os.system("pip install opencv-python")
    os.system("pip install pypdf")
    os.system("pip install Cython")
    os.system("pip install pypdf")
    os.system("pip install tiktoken")
    os.system("pip install openai")
    os.system("pip install sentence_transformers")
    os.system("pip install pyxml2pdf")

    """
end