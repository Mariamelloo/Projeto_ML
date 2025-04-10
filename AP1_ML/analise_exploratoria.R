# Estatísticas descritivas
summary(dados)

dados <- dados %>%
  mutate(across(c(fixed.acidity, volatile.acidity, citric.acid), as.numeric))


# Gráfico de dispersão para variáveis numéricas
ggplot(dados, aes(x = fixed.acidity, y = volatile.acidity)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Relação entre acidez fixa e acidez volátil")

# Convertendo a variável 'alcohol' para numérica
dados$alcohol <- as.numeric(dados$alcohol)

# Verificando se a conversão foi bem-sucedida
summary(dados$alcohol)


# Histograma para verificar distribuição
ggplot(dados, aes(x = alcohol)) +
  geom_histogram(bins = 30) +
  labs(title = "Distribuição do teor alcoólico")

# Boxplot para verificar outliers
ggplot(dados, aes(y = quality)) +
  geom_boxplot() +
  labs(title = "Boxplot da qualidade")
