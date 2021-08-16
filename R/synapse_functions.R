create_synapse_login <- function(){
  if("use_conda_env.R" %in% list.files("R")) source("R/use_conda_env.R")
  synapseclient <- reticulate::import("synapseclient")
  syn <- synapseclient$Synapse()
  syn$login()
  return(syn)
}

store_file_in_synapse <- function(syn, file, parent_id, remove_file = T){
  file <- reticulate::import("synapseclient")$File(file, parent_id)
  syn$store(file)
  if(remove_file) rm(file)
}

