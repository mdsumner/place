## code to prepare `DATASET` dataset goes here
city <- tibble::as_tibble(maps::world.cities) |>  dplyr::transmute(name, lon = long, lat, country = country.etc, pop, capital)

usethis::use_data(city, overwrite = TRUE)
usethis::use_data(city, overwrite = TRUE, internal = TRUE)
