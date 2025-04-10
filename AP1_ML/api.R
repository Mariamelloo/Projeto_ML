library(plumber)
library(jsonlite)

# Carregando os modelos salvos
modelo_linear <- readRDS("modelo_linear.rds")
modelo_logistico <- readRDS("modelo_logistico.rds")

#* @apiTitle API de Modelos de Machine Learning
#* @apiDescription API para predição e classificação usando modelos de ML
#* @apiVersion 1.0.0

#* Endpoint de predição
#* @get /predicao
#* @param valor:numeric Valor de entrada para predição
#* @response 200 Resultado da predição
#* @response 400 Erro na entrada
#* @tag Regressão Linear
function(valor = NULL) {
  if (is.null(valor) || !is.numeric(as.numeric(valor))) {
    return(list(error = "Valor de entrada inválido. Forneça um número."))
  }
  
  # Certifique-se de que a variável corresponda ao nome correto usado no treinamento
  novo_dado <- data.frame(varX = as.numeric(valor))
  
  # Fazendo a predição
  predicao <- predict(modelo_linear, newdata = novo_dado)
  
  return(list(
    entrada = as.numeric(valor),
    predicao = predicao
  ))
}

#* Endpoint de classificação
#* @get /classificacao
#* @param fixed_acidity:numeric Valor de fixed.acidity para classificação
#* @response 200 Resultado da classificação
#* @response 400 Erro na entrada
#* @tag Regressão Logística
function(fixed_acidity = NULL) {
  if (is.null(fixed_acidity) || !is.numeric(as.numeric(fixed_acidity))) {
    return(list(error = "Valor de entrada inválido. Forneça um número para fixed_acidity."))
  }
  
  # IMPORTANTE: Substitua o ponto por underscore no nome da variável no R
  # O R não aceita bem pontos em nomes de variáveis em URLs
  novo_dado <- data.frame(fixed.acidity = as.numeric(fixed_acidity))
  
  # Fazendo a predição
  prob <- predict(modelo_logistico, newdata = novo_dado, type = "response")
  classe <- ifelse(prob > 0.5, 1, 0)
  
  return(list(
    entrada = as.numeric(fixed_acidity),
    probabilidade = prob,
    classe_prevista = classe
  ))
}