library(plumber)

# Carregando e executando a API
api <- plumb("api.R")
api$run(host = "0.0.0.0", port = 8000)

