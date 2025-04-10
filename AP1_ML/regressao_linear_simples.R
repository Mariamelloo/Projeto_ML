# DIVIDINDO O DATASET

summary(dados$alcohol)
length(dados$alcohol)

# Verificando os valores únicos de alcohol
unique(dados$alcohol)

# Verificando se há valores ausentes
sum(is.na(dados$alcohol))

# Removendo linhas com valores ausentes em alcohol
dados <- dados[!is.na(dados$alcohol), ]

# Dividindo os dados em treino e teste
set.seed(123)  # Para reprodutibilidade
indices <- createDataPartition(dados$alcohol, p = 0.7, list = FALSE)
treino <- dados[indices, ]
teste <- dados[-indices, ]

# Convertendo fixed.acidity para numérico, caso seja um fator
dados$fixed.acidity <- as.numeric(dados$fixed.acidity)
teste$fixed.acidity <- as.numeric(teste$fixed.acidity)
teste$alcohol <- as.numeric(teste$alcohol)


# CRIANDO E TREINANDO O MODEL

# Criando o modelo de regressão linear
modelo_linear <- lm(alcohol ~ fixed.acidity, data = treino)

# Resumo do modelo
summary(modelo_linear)

# AVALIANDO MODELO

# Fazendo predições no conjunto de teste
predicoes <- predict(modelo_linear, newdata = teste)
# Verificando se as predições são numéricas
predicoes <- as.numeric(predicoes)


# Calculando métricas de avaliação
# R²
r_squared <- summary(modelo_linear)$r.squared

# MAE (Mean Absolute Error)
mae <- mean(abs(teste$alcohol - predicoes))

# Exibindo o resultado
cat("MAE:", mae)

# RMSE (Root Mean Square Error)
rmse <- sqrt(mean((teste$alcohol - predicoes)^2))

# Imprimindo métricas
cat("R²:", r_squared, "\nMAE:", mae, "\nRMSE:", rmse)

# Gráfico de dispersão com linha de regressão
ggplot(teste, aes(x = fixed.acidity, y = alcohol)) +
  geom_point() +
  geom_line(aes(y = predicoes), color = "red") +
  labs(title = "Valores reais vs. Predições")

# SALVANDO MODELO

# Salvando o modelo para uso posterior na API
saveRDS(modelo_linear, "modelo_linear.rds")
