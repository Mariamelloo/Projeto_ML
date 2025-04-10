install.packages("tidyverse")
install.packages("nortest")
install.packages("corrplot")
install.packages("glmnet")
install.packages(c("plumber", "jsonlite"))

# Carregando pacotes necessários
library(tidyverse)
library(caret)
library(ggplot2)
library(corrplot)
library(nortest)
library(caret)
library(glmnet)
library(pROC)

# Carregando o dataset
dados <- read.csv("winequality-red.csv")

# Visualização inicial
head(dados)
str(dados)
summary(dados)

# Dividindo a coluna 'fixed.acidity.volatile.acidity.citric.acid.residual.sugar.chlorides.free.sulfur.dioxide.total.sulfur.dioxide.density.pH.sulphates.alcohol.quality' em várias colunas
dados <- dados %>%
  separate(fixed.acidity.volatile.acidity.citric.acid.residual.sugar.chlorides.free.sulfur.dioxide.total.sulfur.dioxide.density.pH.sulphates.alcohol.quality, 
           into = c("fixed.acidity", "volatile.acidity", "citric.acid", "residual.sugar", "chlorides", 
                    "free.sulfur.dioxide", "total.sulfur.dioxide", "density", "pH", "sulphates", 
                    "alcohol", "quality"), sep = ";")

# Verificando os dados após a separação
View(dados)
