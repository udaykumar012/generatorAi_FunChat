from flask import Flask,request

from dotenv import load_dotenv
from langchain import HuggingFaceHub, LLMChain
from langchain import PromptTemplate

import asyncio
#to identify current module or application to render
app = Flask(__name__) 


@app.route('/',methods = ['POST'])
def question():
    ques = request.form.get('msg')
    
    # load_dotenv()
    # hub_llm = HuggingFaceHub(repo_id="gpt2",
    #                         model_kwargs={'temperature': 0.8,'max_length' :100}
    #                         )
    # prompt = PromptTemplate(
    #     input_variables=["sqlQues"],
    #     template="Translate English to SOL: {question}",
    # )
    # hub_chain = LLMChain(prompt=prompt, llm=hub_llm, verbose=True)

    # res = str( hub_chain.run(ques))
    # print(res)
   
  

    return ques

if __name__ == '__main__':
    app.run(debug=True)
