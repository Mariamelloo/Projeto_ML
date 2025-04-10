# Convertendo a variável para numérica (exemplo com 'alcohol')
dados$alcohol <- as.numeric(dados$alcohol)

# Verificando se a conversão foi bem-sucedida
summary(dados$alcohol)


# Teste de Shapiro-Wilk
shapiro_test <- shapiro.test(dados$alcohol)
print(shapiro_test)

# Teste de Kolmogorov-Smirnov
ks_test <- lillie.test(dados$alcohol)
print(ks_test)

# Gráfico Q-Q plot para visualizar normalidade
qqnorm(dados$alcohol)
qqline(dados$alcohol, col = "red")
