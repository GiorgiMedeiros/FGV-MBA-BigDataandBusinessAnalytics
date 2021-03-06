########################################################################################
########################################################################################
### Autovalores e autovetores.
########################################################################################
########################################################################################

# Limpando o console.
cat("\014") 
# Limpando o Global Environment.
rm(list = ls())

# Carregando dados de caracter�sticas de uma amostra de flores quanto a suas medidas
# de s�palas e p�talas.
data(iris)
head(iris, 3)

# Ficando apenas com os dados quantitativos dispon�veis (eleg�veis a an�lise de 
# Componentes Principais).
iris.quant <- iris[, 1:4]
head(iris.quant,3)

# Padronizando os valores para Z score.
# help(scale)
iris.quant.z <- scale(iris.quant)
colMeans(iris.quant.z)

# Calculando as matrizes de covari�ncia e correla��o para a base com as vari�veis
# originais e para a base com as vari�veis padronizadas.
cor(iris.quant)
cov(iris.quant)
cor(iris.quant.z)
cov(iris.quant.z)
# Escolhendo a matriz covari�ncia dos dados padronizados para seguir em frente:
matriz.covariancia <- cov(iris.quant.z)

# Calculando autovalores e autovetores da matriz de covari�ncia dos dados padroni-
# zados z score.
autovar.autovet <- eigen(matriz.covariancia)
autovalores <- autovar.autovet$values
autovetores <- autovar.autovet$vectors

# Fazendo a prova real de que os autovalores e autovetores est�o calculados corre-
# tamente. Somente para os primeiros:
autovalores.primeiro <- autovalores[1]
autovetores.primeiro <- autovetores[,1]

matriz.covariancia %*% autovetores.primeiro
autovalores.primeiro %*% autovetores.primeiro

# Fazendo a An�lise de Componentes Principais (PCA - Principal Component Analysis).
help(prcomp)
componentes.principais <- prcomp(iris.quant.z)
componentes.principais
summary(componentes.principais)
# S� para ver que o resultado seria diferente se fizesse com os dados n�o normaliza-
# dos.
prcomp(iris.quant)
summary(prcomp(iris.quant))
# help(plot): O type "l" � para fazer um gr�fico de linhas.
plot(componentes.principais, type = "l")

# Encontrar os scores que determinam os componentes principais em fun��o das vari�-
# veis originais.
autovetores.t <- t(autovetores)
autovalores.quad <- matrix(autovalores,nrow=ncol(iris.quant.z),ncol=ncol(iris.quant.z))
variancia.x.quad <- matrix(diag(cov(iris.quant.z)),nrow=ncol(iris.quant.z),ncol=ncol(iris.quant.z))
scores <- autovetores.t * sqrt(autovalores.quad) / variancia.x.quad
# Dar nomes aos eixos de scores.
cargas <- componentes.principais$rotation
nomes.variaveis <- rownames(cargas)
nomes.componentes <- colnames(cargas)
dimnames(scores) <- list(nomes.componentes,nomes.variaveis)

