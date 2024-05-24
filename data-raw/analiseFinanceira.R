#Analise de lucratividade por Categoria

# Calcular a lucratividade de diferentes categorias
# de produtos, levando em conta o custo dos produtos e o preço de venda.

#Importando as bibliotecas




#importando os arquivos necessários.

#preco de compra, e de venda

notaFiscal <- readr::read_csv("data-raw/olist_order_payments_dataset.csv")
#payment_value ou valor do pagamento - chave primaria order_id

encomendasDataset <- readr:: read_csv("data-raw/olist_order_items_dataset.csv")
#possui o valor do item e do frete

df <- notaFiscal |> 
  left_join(encomendasDataset,by = "order_id")






  




