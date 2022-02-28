## file structure
#if (! file.exists("data_raw")) dir.create("data_raw")

#if (!file.exists("data_raw/surveys.csv")) {
#    download.file("https://ndownloader.figshare.com/files/2292172",
#                  "data_raw/surveys.csv")
#}

## knitr options
library(knitr)
library(methods)
library(tidyverse)
library(kableExtra)
library(rmarkdown)
library(patchwork)
suppressPackageStartupMessages(library(tidyverse))
knitr::opts_chunk$set(fig.path='img/reproducibility-',
                      comment = "#>", purl = FALSE, fig.keep='last')

### Custom hooks

## hook for challenges answers

knitr::knit_hooks$set(answer = function(before, options, envir) {
    if (before) {
        paste(
            "<div class=\"accordion\">",
              "<h3 class=\"toc-ignore\">Answer</h3>",
              "<div style=\"background: #fff;\">",  sep = "\n")
    } else {
        paste("</div>", "</div>", sep = "\n")
    }
})

eng_text_answer <- knitr:::eng_html_asset(
                               paste(
                                   "<div class=\"accordion\">",
                                   "<h3 class=\"toc-ignore\">Answer</h3>",
                                   "<div style=\"background: #fff;\">",
                                   "<p>",  sep = "\n"),
                               paste(
                                   "</div>", "</div>", "</p>", sep = "\n"
                               )
                           )

knitr::knit_engines$set(text_answer = eng_text_answer)
