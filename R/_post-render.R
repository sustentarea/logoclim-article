library(beepr)
library(checkmate)
library(cli)
library(fs)
library(here)
library(quartor) # github.com/danielvartan/quartor
library(readr)
library(stringr)

# Replace Special Characters -----

files <- c(
  here("README.md"),
  here("index.qmd"),
  here("paper", "paper.md"),
  here("references.bib"),
  here("paper", "paper.bib")
)

special_characters <- list(
  # em_dash = c("–", "-"),
  apostrophe = c("’", "'")
)

for (i in files) {
  for (j in special_characters) {
    data <-
      i |>
      read_lines() |>
      str_replace_all(
        pattern = j[1],
        replacement = j[2]
      )

    data |> write_lines(i)
  }
}

# Create/Update JOSS Paper -----

if (!test_directory_exists(here("paper"))) {
  dir_create(here("paper"))
}

if (!test_file_exists(here("paper", "paper.md"))) {
  file_create(here("paper", "paper.md"))
}

swap_list <- list(
  paper = list(
    from = here("index.qmd"),
    to = here("paper", "paper.md"),
    begin_tag = "%:::% paper begin %:::%",
    end_tag = "%:::% paper end %:::%",
    value = NULL,
    quarto_render = FALSE
  )
)

for (i in swap_list) {
  quartor:::swap_value_between_files(
    from = i$from,
    to = i$to,
    begin_tag = i$begin_tag,
    end_tag = i$end_tag,
    value = i$value,
    quarto_render = i$quarto_render,
    cite_method = "biblatex"
  )
}

if (test_directory_exists(here("docs"))) {
  if (test_directory_exists(here("paper", "images"))) {
    dir_delete(here("paper", "images"))
  }

  dir_copy(
    path = here("docs", "images"),
    new_path = here("paper", "images"),
    overwrite = TRUE
  )
}

if (test_file_exists(here("references.bib"))) {
  file_copy(
    path = here("references.bib"),
    new_path = here("paper", "paper.bib"),
    overwrite = TRUE
  )
}

data <-
  here("paper", "paper.md") |>
  read_lines() |>
  str_replace(
    pattern = "(?<=date: ).*",
    replacement =  Sys.Date() |> format("%e %B %Y")
  )

data |> write_lines(here("paper", "paper.md"))

# Warn About Fixing Figures and Figure References -----

cli_alert_warning(
  paste0(
    "Fix figures and figure references in {.strong paper/paper.md}. ",
    "See {.url https://joss.readthedocs.io/en/latest/example_paper.html} ",
    "for more information."
  )
)

# Check If the Script Ran Successfully -----

beep(1)

Sys.sleep(3)
