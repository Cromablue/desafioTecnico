#importando biblitecas necessárias
library(readr)
library(lubridate)
library(dplyr)
library(ggplot2)



#problema:
# Avaliar o desempenho de diferentes transportadoras com base 
# no tempo de entrega e na satisfação do cliente. Requisitos: avaliação, tempo de espera.

listaDeEntregas <- readr::read_csv("data-raw/olist_orders_dataset.csv")
##quando foi aprovado e quando foi enviado.

listaAvaliacao <- readr::read_csv("data-raw/olist_order_reviews_dataset.csv")
##comentario//avaiacao


df <- listaDeEntregas |> 
  left_join(listaAvaliacao, by = "order_id") 


#tratando os dados e criando um dataframe apenas com o que vai ser necessario

df <- na.omit(df)

dfTratado <- df |> 
  select(order_estimated_delivery_date,order_delivered_customer_date,review_score)


# Função para calcular a diferença em dias entre dois timestamps
calcular_diferenca_dias <- function(dataframe, coluna_inicio, coluna_fim) {
  dataframe  |> 
    mutate(dias_ate_entrega = ifelse(!is.na({{coluna_fim}}), as.integer(as.Date({{coluna_fim}}) - as.Date({{coluna_inicio}})), "Não Entregue"))
}

# Aplicando a função ao dataframe
dfTratado <- calcular_diferenca_dias(dfTratado, order_estimated_delivery_date, order_delivered_customer_date)


dfTratado <- calcular_diferenca_dias(dfTratado, order_estimated_delivery_date, order_delivered_customer_date)

# Agrupando todos os valores menores ou iguais a zero
dfTratado <- dfTratado |> 
  mutate(dias_ate_entrega = ifelse(dias_ate_entrega <= 0, 0, dias_ate_entrega))

#dataframe com os dados necessários
df_atraso <-  dfTratado |> 
  select(dias_ate_entrega,review_score)

plot(df_atraso)