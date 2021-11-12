# Pacotes utilizados
library(rpart)
library(ggplot2)
library(caTools)
library(rpart.plot)

# Análisando o dataset
str(kyphosis)
head(kyphosis)
plot(kyphosis)

# Modelo de Árvore de Decisão
arvore <- rpart(Kyphosis ~ ., method = "class", data = kyphosis)
printcp(arvore)

# Plotando a Árvore de Decisão e inserindo as descrições
plot(arvore, uniform = T, main = "Árvore de Decisão p/ Kyphosis")
text(arvore, splits = T, all = T)

# Plotagem de forma mais simples e menos poluída
prp(arvore)

# Separando em dados de treino e teste
split = sample.split(kyphosis$Kyphosis, SplitRatio = 0.70)

treino <- subset(kyphosis, split == T)
teste <- subset(kyphosis, split == F)

# Criando um novo modelo a partir dos dados de treino
arvore_2 <- rpart(Kyphosis ~ ., method = "class", data = treino)

# Previsão
previsao <- predict(arvore_2, teste[-1], type = "class")

# Comparando os valores reais com os previstos
realxprev <- data.frame(teste$Kyphosis, previsao)
print(realxprev)
