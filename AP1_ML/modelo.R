# Fazendo predições no conjunto de teste
predicoes <- predict(modelo_linear, newdata = teste)

# Calculando métricas de avaliação
# R²
r_squared <- summary(modelo_linear)$r.squared

# MAE (Mean Absolute Error)
mae <- mean(abs(teste$varY - predicoes))

# RMSE (Root Mean Square Error)
rmse <- sqrt(mean((teste$varY - predicoes)^2))

# Imprimindo métricas
cat("R²:", r_squared, "\nMAE:", mae, "\nRMSE:", rmse)

# Gráfico de dispersão com linha de regressão
ggplot(teste, aes(x = varX, y = varY)) +
  geom_point() +
  geom_line(aes(y = predicoes), color = "red") +
  labs(title = "Valores reais vs. Predições")