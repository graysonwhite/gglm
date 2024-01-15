---
title: 'gglm: An R package implementing the grammar of graphics for linear model diagnostic plots'
tags:
  - R
  - linear models
  - diagnostic plots
  - grammar of graphics
  - ggplot2
authors:
  - name: Grayson W. White
    orcid: 0000-0003-4993-2792
    affiliation: 1
affiliations:
 - name: Michigan State University, Department of Forestry
   index: 1
date: 15 January 2024
bibliography: paper.bib
citation_author: White
year: 2024
output: 
  rticles::joss_article:
    keep_tex: true
    includes:
      in_header: columns.tex
csl: apa.csl
journal: JOSS
---

# Summary

`gglm` implements an interface to produce publication-ready model diagnostic
plots that complies with the grammar of graphics [@wickham2010]. Further, `gglm`
utilizes the `broom` and `broom.mixed` R packages to provide support for
diagnostic plots produced from a variety of model object classes across a wide
variety of R packages [@broom; @broom.mixed]. A quartet of diagnostic plots can 
be quickly created using `gglm`'s homonymous function, or through instructive
and intuitive layer functions added to a `ggplot2` object [@ggplot2].

# Statement of need

When scientists, statistical practitioners, students, and others implement
statistical models, it is of the utmost importance that the modeling assumptions
are verified through visual diagnostics in order to ensure valid statistical 
inference. The R statistical software language provides a method for producing
diagnostic plots for linear model objects created with `stats::lm`, however 
these plots are visually unappealing, inconsistent with diagnostic plots 
produced for other R packages and model types, and out of place in modern 
statistics and data science courses focused on learning R with the `tidyverse`
[@tidyverse]. 

`gglm` addresses the described issues with current diagnostic plots in R by
providing a consistent interface for producing beautiful and publication-ready
diagnostic plots for a large variety of R packages and model types (linear 
models, linear mixed models, generalized linear mixed models, etc.). `gglm` 
provides functionality to quickly produce four common diagnostic plots, similar
to `stats::plot.lm`, but produced by `ggplot2`. Further, `gglm` provides a suite
of layer functions adhering to the grammar of graphics which allow the user to
create and fine-tune their diagnostic plots through `ggplot2`'s intuitive 
interface. The layer functions are particularly applicable in modern courses 
teaching linear regression where students have already learned `ggplot2`, and in
particular they are used in Harvard University's introductory statistics course
[@mcconville2023]. Outside of educational benefits, `gglm` has potential to
allow researchers to more easily publish elegant diagnostic plots. `gglm` has
been downloaded from CRAN over 23,000 times as of January 2024. 

# Usage and Philosophy

`gglm` has a simple philosophy for usage of the package: "be easy, intuitive, 
and customizable". This philosophy comes about from the understanding that an 
individual producing a diagnostic plot will be in one of two camps: 1) the
individual who wants an *easy* to use tool that allows them to quickly check
their model diagnostics, or 2) the individual who wants an *intuitive and 
customizable* tool that allows them to look closely at their diagnostics for the
purposes of education, fine-tuning for publication, or other reasons. `gglm` 
satisfies the individuals in both camps.

The `gglm::gglm` function is made for folks in the first camp who are looking
a more aesthetically pleasing alternative to `stats::plot.lm`. In practice, the
process of using `gglm::gglm` is as simple as and more general than using 
`stats::plot.lm`, with steps as follows:

+ fit a model of any class listed in `gglm::list_model_classes`,
+ call `gglm::gglm` on the saved model object. 

The `gglm::stat_*` functions are thus for the individual in the second camp. 
`gglm` provides seven functions of this sort, including those that produce the 
following plots: Cook's distance by leverage, Cook's distance by observation
number, fitted values by residual values, normal QQ, residual histogram, 
residual values by leverage, and scale by location. The steps to produce a 
diagnostic plot with these functions are more fluid than with `gglm::gglm`, 
but are easy to understand provided the user has an understanding of how to use
`ggplot2`. One may use the workflow: 

+ fit a model of any class listed in `gglm::list_model_classes`,
+ provide the saved model object as data to `ggplot2::ggplot`,
+ add their intended diagnostic plot layer,
+ add any more `ggplot2` layers such as themes, labels, annotations, and more to
create their custom diagnostic plot. 

# Comparison to Other Packages

Functionality similar to that of `gglm`'s is provided by a variety of R 
packages. As mentioned throughout, `stats` provides a `plot` method for 
producing diagnostic plots for `lm` objects with base R graphics [@R]. Further,
`lindia` produces diagnostic plots for `lm` objects with `ggplot2` graphics, but
does not include functions that adhere with the grammar of graphics. Finally, 
many packages provide methods for plotting diagnostics based on their own model 
classes (see, e.g. `lme4::plot.merMod`), however these methods are do not have
consistent usage across packages [@lme4]. 

# References