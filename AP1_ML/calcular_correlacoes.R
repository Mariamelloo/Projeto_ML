# Verificando se as variáveis existem e são numéricas
str(dados$alcohol)
str(dados$quality)

# Convertendo variáveis para numéricas se necessário
dados$alcohol <- as.numeric(dados$alcohol)
dados$quality <- as.numeric(dados$quality)

# Correlação de Pearson
cor_pearson <- cor.test(dados$alcohol, dados$quality, method = "pearson")
print(cor_pearson)

table(dados$alcohol)
table(dados$quality)

# Adicionando jitter (pequenas variações) aos dados para evitar empates
dados$alcohol_jitter <- jitter(dados$alcohol, amount = 0.1)
dados$quality_jitter <- jitter(dados$quality, amount = 0.1)

# Teste de Spearman com dados ajustados
cor_spearman_jitter <- cor.test(dados$alcohol_jitter, dados$quality_jitter, method = "spearman")
print(cor_spearman_jitter)

# Matriz de correlação para múltiplas variáveis
matrix_cor <- cor(dados[, c("fixed.acidity", "volatile.acidity", "citric.acid", "alcohol")], method = "pearson")
corrplot(matrix_cor, method = "circle")

