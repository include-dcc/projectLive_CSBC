require(magrittr)
devtools::load_all()
syn <- create_synapse_login()

publications <-
  projectlive.modules::get_synapse_tbl(
    syn,
    "syn21868591",
    columns = c(
      "grantName",
      "publicationId",
      "publicationYear",
      "tissue",
      "theme"
    )
  ) %>%
  dplyr::mutate(
    "publicationYear" = as.factor(.data$publicationYear)
  )

saveRDS(publications, "pubs.RDS")
store_file_in_synapse(
  syn,
  "pubs.RDS",
  "syn24172460"
)
