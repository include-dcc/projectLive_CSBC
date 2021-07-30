require(magrittr)
devtools::load_all()
syn <- create_synapse_login()

studies <- projectlive.modules::get_synapse_tbl(syn, "syn21918972") %>% 
  dplyr::select("grantId", "grantType")

datasets_created<-  projectlive.modules::get_synapse_tbl(syn, "syn21889931") %>% 
  dplyr::select("id", "createdOn")

datasets <- projectlive.modules::get_synapse_tbl(syn, "syn21897968") %>% 
  dplyr::mutate(
    "accessType" = "PUBLIC",
    "grantId" = purrr::map_chr(.data$grantId, purrr::pluck, 1)
  ) %>% 
  dplyr::left_join(studies) %>% 
  dplyr::left_join(datasets_created, by = c("datasetId" = "id")) %>% 
  projectlive.modules::format_date_columns() %>% 
  dplyr::select(-"createdOn")
  

saveRDS(datasets, "datasets.RDS")
store_file_in_synapse(
  syn,
  "datasets.RDS",
  "syn24172460"
)

  
  