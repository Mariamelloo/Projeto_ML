# PREPARAR DADOS

dados$varBinaria <- ifelse(dados$alcohol > 10, 1, 0) # variável binária com base na variável alcohol
dados$varBinaria <- as.factor(dados$varBinaria) # garantindo que a variável binária seja um fator

# Dividindo os dados
set.seed(123)
indices <- createDataPartition(dados$varBinaria, p = 0.7, list = FALSE)
treino_log <- dados[indices, ]
teste_log <- dados[-indices, ]

# CRIAR MODELO

# Verificando a distribuição de varBinaria em relação às variáveis independentes
table(treino_log$varBinaria, treino_log$fixed.acidity)
table(treino_log$varBinaria, treino_log$volatile.acidity)
table(treino_log$varBinaria, treino_log$citric.acid)


# Ajustando o modelo com mais iterações
modelo_logistico <- glm(varBinaria ~ fixed.acidity + volatile.acidity + citric.acid, 
                        data = treino_log, 
                        family = "binomial")


summary(modelo_logistico)

# AVALIAR MODELO

# Fazendo predições no conjunto de teste
treino_log$fixed.acidity <- factor(treino_log$fixed.acidity)
teste_log$fixed.acidity <- factor(teste_log$fixed.acidity, levels = levels(treino_log$fixed.acidity))
treino_log$fixed.acidity <- as.numeric(treino_log$fixed.acidity)
teste_log$fixed.acidity <- as.numeric(teste_log$fixed.acidity)
treino_log$volatile.acidity <- as.numeric(treino_log$volatile.acidity)
teste_log$volatile.acidity <- as.numeric(teste_log$volatile.acidity)
treino_log$citric.acid <- as.numeric(treino_log$citric.acid)
teste_log$citric.acid <- as.numeric(teste_log$citric.acid)

predicoes_prob <- predict(modelo_logistico, newdata = teste_log, type = "response")

# Convertendo as probabilidades em classes (0 ou 1), com um limiar de 0.5
predicoes_classe <- ifelse(predicoes_prob > 0.5, 1, 0)

# Matriz de confusão
confusionMatrix(factor(predicoes_classe), teste_log$varBinaria)# Calculando a curva ROC
roc_obj <- roc(teste_log$varBinaria, predicoes_prob)

# Plotando a curva ROC
plot(roc_obj, main = "Curva ROC")

# Calculando a AUC
auc_value <- auc(roc_obj)
cat("AUC:", auc_value)

saveRDS(modelo_logistico, "modelo_logistico.rds")
