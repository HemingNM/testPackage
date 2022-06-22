## code to prepare `sites-raw` dataset goes here

# vamos criar uma matriz com abundancia de spp x sites
# cria vetor de abundancias e de probabilidades
abund <- 0:10
sqrt(1/(1+5*abund))
# plot(abund, sqrt(1/((1+5*abund))))

# especifica o n de sites e de spp
nsites <- 3*4
nspp <- 5

# uso a função 'sample()' para gerar dados de cada localidade
set.seed(100)

#  cria a matriz, primeiro uma lista
sitesl <- lapply(seq_len(nsites),
                 function(i, x, size){
                   sample(x, size, replace = T, prob = sqrt(1/(1+5*x)))
                 }, x=abund, size=nspp)

# agora transformamos a lista em matriz
sites <- do.call(rbind, sitesl)
colnames(sites) <- paste0("sp", 1:ncol(sites))
rownames(sites) <- paste0("s_", 1:nrow(sites))
sites

### salvando
write.csv(sites, "data-raw/sites.csv")

## salvando como código fonte
dput(sites)
dput(data.frame(sites))
fil <- tempfile()
dput(sites, fil)
dget(fil)

### espacializando os dados
library(terra)
# vamos 'espacializar' nosso conjunto de dados
# cada layer será a abund de uma espécie
# aqui todas, transformamos a matriz em uma matriz com múltuplas dimensões: array
sitesa <- array(sites, dim = c(3,4,5), # dim: Linhas, Colunas, Camadas
                dimnames = list(NULL, NULL, colnames(sites)))

# Podemos transformar o array diretamente em um conjunto de dados espacialiados
sitesr <- rast(sitesa)
names(sitesr) <- paste0("sp", 1:nlyr(sitesr))
sitesr
plot(sitesr)



### salvando os dados no pacote
?usethis::use_data
usethis::use_data(sites, overwrite = TRUE)
# ✔ Creating 'data/'
# ✔ Saving 'sites' to 'data/sites.rda'
# • Document your data (see 'https://r-pkgs.org/data.html')

### arquivos raster não podem ser salvos como ".rda"
# pois não são exportáveis
# https://cran.r-project.org/web/packages/future/vignettes/future-4-non-exportable-objects.html
# Such objects cannot be saved to file by one R process and then later be
# reloaded in another R process and expected to work correctly

## então salvamos em outro diretório
if(!dir.exists("inst/extdata")) dir.create("inst/extdata", recursive = T)
terra::writeRaster(sitesr, "inst/extdata/sitesr.tif", overwrite=TRUE)
