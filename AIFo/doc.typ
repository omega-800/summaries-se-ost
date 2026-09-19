#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

= Machine Learning (ML)

There are many different AI research fields and AI applications. Algorithms
and applications where a computer learns from data are typically in the field of
statistical machine learning (ML).

/ Computer: performs a mapping from input to output.
/ Processing: any sort of non-trivial "calculation" (mapping) or information processing
/ Input: any sort of data/information (sensory input, bits, mechanical configuration...)
/ Output: any sort of response (data, actions, new state of a system...)

#todo[W1 slides2 14..17]
