library(tidyverse)
library(AzureStor)
library(sys)

setwd("~/Desktop/Skola/azure")

# Download file from azure container --------------------------------------

endp <-
  storage_endpoint("address-to-blob",
                   key = Sys.getenv('AZURESTORAGEKEY'))

container <- storage_container(endp, "privateclientdata")
list_blobs(container)

storage_download(
  container,
  "clients_private.csv",
  "~/Desktop/Skola/azure/clients_private.csv",
  overwrite = TRUE
)


# Modify file content -----------------------------------------------------

read_csv("clients_private.csv") %>%
  mutate(score = age * 1.6) %>% 
  write_csv("~/Desktop/Skola/azure/clients_private_mod.csv")

# Upload modified file as new azure blob ----------------------------------
upload_blob(container, src = "~/Desktop/Skola/azure/clients_private_mod.csv", dest =
              "clients_private_mod.csv")

upload_blob(container, src = "~/Desktop/Skola/azure/test.csv", dest =
              "test.csv")
delete_storage_file(container,"test.csv")  
