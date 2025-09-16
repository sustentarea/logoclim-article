# Load Packages -----

library(brandr)
library(downlit)
library(ggplot2)
library(here)
library(httpgd) # github.com/nx10/httpgd
library(knitr)
library(magrittr)
library(quartor) # github.com/danielvartan/quartor
library(ragg)
library(readr)
library(rlang)
library(rutils) # github.com/danielvartan/rutils
library(stringr)
library(xml2)

# Set General Options -----

options(
  dplyr.print_min = 6,
  dplyr.print_max = 6,
  pillar.max_footer_lines = 2,
  pillar.min_chars = 15,
  scipen = 10,
  digits = 10,
  stringr.view_n = 6,
  pillar.bold = TRUE,
  width = 77 # 80 - 3 for #> comment
)

# Set Variables -----

set.seed(2025)

# Set `knitr`` -----

clean_cache() |> shush()

opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  root.dir = here(),
  dev = "ragg_png",
  dev.args = list(bg = "transparent"),
  fig.showtext = TRUE
)

# Run `rbbt` -----

## Uncheck the option "Apply title-casing to titles" in Zotero Better BibTeX
## preferences (Edit > Settings > Better BibTeX > Miscellaneous).

# (2024-08-25)
# This function should work with any version of BetterBibTeX (BBT) for Zotero.
# Verify if @wmoldham PR was merged in the `rbbt` package (see issue #47
# <https://github.com/paleolimbot/rbbt/issues/47>). If not, install `rbbt`
# from @wmoldham fork `remotes::install_github("wmoldham/rbbt", force = TRUE)`.

bbt_write_quarto_bib(
  bib_file = here("references.bib"),
  dir = c("."),
  pattern = "\\.qmd$",
  wd = here()
)

# Fix Brackets in `.bib` Files -----

here("references.bib") |>
  read_lines() |>
  str_replace_all(
    pattern = fixed("\\{\\vphantom\\}{{"),
    replacement = "{{\\{"
  ) |>
  str_replace_all(
    pattern = fixed("}}\\vphantom\\{\\}"),
    replacement = "\\}}}"
  ) |>
  write_lines(here("references.bib"))
