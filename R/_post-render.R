# library(beepr)
# library(checkmate)
# library(fs)
# library(here)
# library(lubridate)
# library(quartor) # github.com/danielvartan/quartor
# library(readr)
# library(stringr)

# Update `LICENSE.md` -----

file <- here::here("LICENSE.md")

data <-
  file |>
  readr::read_lines() |>
  stringr::str_replace_all(
    pattern = "20\\d{2}",
    replacement = as.character(Sys.Date() |> lubridate::year())
  )

data |> readr::write_lines(file)

# Create/Update JOSS Paper -----

if (!checkmate::test_directory_exists(here::here("paper"))) {
  fs::dir_create(here::here("paper"))
}

if (!checkmate::test_file_exists(here::here("paper", "paper.md"))) {
  fs::file_create(here::here("paper", "paper.md"))
}

swap_list <- list(
  paper = list(
    from = here::here("index.qmd"),
    to = here::here("paper", "paper.md"),
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

if (checkmate::test_directory_exists(here::here("docs"))) {
  if (checkmate::test_directory_exists(here::here("paper", "images"))) {
    fs::dir_delete(here::here("paper", "images"))
  }

  fs::dir_copy(
    path = here::here("docs", "images"),
    new_path = here::here("paper", "images"),
    overwrite = TRUE
  )
}

if (checkmate::test_file_exists(here::here("references.bib"))) {
  fs::file_copy(
    path = here::here("references.bib"),
    new_path = here::here("paper", "paper.bib"),
    overwrite = TRUE
  )
}

data <-
  here::here("paper", "paper.md") |>
  readr::read_lines() |>
  stringr::str_replace(
    pattern = "(?<=date: ).*",
    replacement =  Sys.Date() |> format("%e %B %Y")
  )

data |> readr::write_lines(here::here("paper", "paper.md"))

# Check If the Script Ran Successfully -----

beepr::beep(1)

Sys.sleep(3)
