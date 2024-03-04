#!/bin/bash

source .env

# the paper used 8 few shot and tested:
# text-davinci-002 with ordering={postorder,preorder}, min-hops=1, max-hops=5, hops-skip=2, ontology={fictional,true,false}
# text-ada-001, text-babbage-001, text-curie-001, davinci, text-davinci-001 with
# ordering=preorder, min-hops=1, max-hops=3, hops-skip=2, ontology={fictional,true,false}

# follow the latter configuration for the remaining models, with 30 trials only.

# the context is too long for ada, babbage and curie, so ignore them

SIZES=( "text-davinci-003" "gpt-4-0613" "gpt-4-1106-preview"  "gpt-3.5-turbo-0613" )
ONTOLOGIES=( "fictional" "false" )

for SIZE in "${SIZES[@]}"; do
  for ONTOL in "${ONTOLOGIES[@]}"; do
    echo "Running eval for model $SIZE with ontology $ONTOL"
  python run_experiment.py --model-name gpt3 --model-size $SIZE --api-key $OPENAI_API_KEY --num-trials 100 --min-hops 1 --max-hops 3 --hops-skip 2       --ontology $ONTOL --ordering preorder --resume
  done
done


ONTOLOGIES=(  "true" )
for SIZE in "${SIZES[@]}"; do
  for ONTOL in "${ONTOLOGIES[@]}"; do
    echo "Running eval for model $SIZE with ontology $ONTOL"
  python run_experiment.py --model-name gpt3 --model-size $SIZE --api-key $OPENAI_API_KEY --num-trials 100 --min-hops 1 --max-hops 3 --hops-skip 2       --ontology $ONTOL --ordering preorder --distractors none --test-distractors none --resume
  done
done
