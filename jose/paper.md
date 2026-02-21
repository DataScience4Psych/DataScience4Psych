---
title: 'Data Science for Psychologists (DS4P): A Modular, Open-Source Learning Module for Transparent and Reproducible Data Analysis in Psychology'
output:
  rticles::joss_article:
    keep_md: TRUE
  rmarkdown::html_vignette:
    keep_md: TRUE
tags:
  - psychology
  - data science
  - R
  - reproducibility
  - open educational resources
authors:
  - name: S. Mason Garrison^[corresponding author]
    orcid: 0000-0002-4804-6003
    affiliation: 1
affiliations:
 - name: Department of Psychology, Wake Forest University, North Carolina, USA
   index: 1
citation_author: Garrison
csl: apa.csl
journal: JOSE
date: "08 April, 2025"
bibliography: paper.bib
vignette: >
  %\VignetteEncoding{UTF-8}
  %\VignetteIndexEntry{modelingandrelatedness}
  %\VignetteIndexEntry{pedigree}
  %\VignetteEngine{knitr::rmarkdown}
---



```{=html}
<!--Guidance 
JOSS welcomes submissions from broadly diverse research areas. For this reason, we require that authors include in the paper some sentences that explain the software functionality and domain of use to a non-specialist reader. We also require that authors explain the research applications of the software. The paper should be between 250-1000 words. Authors submitting papers significantly longer than 1000 words may be asked to reduce the length of their paper.
Your paper should include:

A list of the authors of the software and their affiliations, using the correct format (see the example below).
A summary describing the high-level functionality and purpose of the software for a diverse, non-specialist audience.
A Statement of need section that clearly illustrates the research purpose of the software and places it in the context of related work.
A list of key references, including to other software addressing related needs. Note that the references should include full names of venues, e.g., journals and conferences, not abbreviations only understood in the context of a specific discipline.
Mention (if applicable) a representative set of past or ongoing research projects using the software and recent scholarly publications enabled by it.
Acknowledgment of any financial support.
-->
```

# Summary

<!--  A summary describing the high-level functionality and purpose of the software for a diverse, non-specialist audience. -->

**Data Science for Psychologists (DS4P)** is an open, GitHub-hosted computational learning module developed to support data science instruction within psychology. Initially launched as a graduate course during the COVID-19 pandemic, DS4P will expand to include undergraduate instruction beginning in Spring 2026 at Wake Forest University.

This multimedia module serves as a flipped textbook, combining embedded video lectures, annotated code examples, readings, slide decks, and hands-on labs. Its instructional approach emphasizes reproducibility and transparency in psychological research. No prior programming or advanced mathematical background is assumed.

DS4P makes extensive use of the R ecosystemb
