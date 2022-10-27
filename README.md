# PrOntoQA
This repo contains PrOntoQA, as described in our paper, [Language Models Are Greedy Reasoners: A Systematic Formal Analysis of Chain-of-Thought](https://arxiv.org/pdf/2210.01240.pdf). PrOntoQA generates question-answering examples with chains-of-thought that describe the reasoning required to answer the questions correctly. The sentences in the examples are syntactically simple and amenable to semantic parsing, and so this code can be used to formally analyze the predicted chain-of-thought from large language models such as GPT-3.

If you use our code in your work, please cite our paper:
```
@article{SaparovHe22,
  author    = {Abulhair Saparov and He He},
  title     = {Language Models Are Greedy Reasoners: A Systematic Formal Analysis of Chain-of-Thought},
  journal   = {CoRR},
  volume    = {abs/2210.01240},
  year      = {2022},
  url       = {https://arxiv.org/abs/2210.01240},
  eprinttype = {arXiv},
  eprint    = {2210.01240},
}
```

## Running experiments
To generate the examples and evaluate models, use [`run_experiment.py`](run_experiment.py). There are a number of command-line flags:
 - `--model-name [gpt3|opt|unifiedqa|dummy]` specifies the model to test. The `dummy` model is a trivial model, used for testing, that outputs nothing for any input.
 - `--model-size <size>` where `<size>` indicates the version or size of the model. For GPT-3, this must be the OpenAI identifier for the model. For example, to use the InstructGPT 350M parameter model, specify `--model-size text-ada-001`.
 - `--ordering [postorder|preorder|random]` specifies the order of the context sentences of each question.
 - `--num-trials <n>` specifies the number of examples per experiment.
 - `--few-shot-examples <n>` specifies the number of few-shot in-context examples given in each experiment example.
 - `--ontology [fictional|true|false]` indicates which ontology type to generate.
 - `--min-hops <n>`, `--max-hops <m>`, `--hops-skip <k>` specifies which hop counts to test. An experiment is run with `n` hops, then another experiment is run with `n + k` hops, `n + 2k`, and so on until the number of hops exceeds `m`.

The output of the experiments are written to a file whose name is automatically determined based on the above flag configuration.
 - `--resume` is another very useful flag that prevents the program from restarting the experiment at trial 0 if partial results already exist. Rather, the program will continue the experiment where it left off.

## Analyzing output
Once `run_experiment.py` has saved the model predictions to files, they can be analyzed with [`analyze_results.py`](analyze_results.py). Without any arguments, this script will reproduce all results figures in our paper.
