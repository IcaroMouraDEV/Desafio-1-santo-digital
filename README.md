# Hackathon Santo Digital

## Desafio 1

### Tecnologias Utilizadas

* mysql
* mysql.connector
* mysql Workbench
* pandas
* python
* matplotlib.pyplot
* numpy
* sklearn.linear_model

### Tarefa I

1. Modelei o banco de dados a partir dos csv
2. Fiz a normalização das tabelas para garantir a consistência dos dados
3. Apos a modelagem construi o [banco de dados](data/data.sql)

![Diagrama Entidade Relacionamento](img/DER.png)

### Tarefa II

#### Item I

- **Objetivo:** Selecionar o productKey e a quantidade total de pedidos para cada produto
- **Filtro:** Considera apenas os produtos da categoria bicicleta e pedidos realizados nos ultimos 2 anos
- **Agrupamento:** Agrupa os resultados pelo ProductKey

#### Item II

- Criar a CTE `orders_per_quarters`
  - **Objetivo**: Contar o número de pedidos por cliente e trimestre
  - **Filtro**: Considera apenas pedidos feitos no ultimo ano fiscal.
  - **Agrupamento**: Agrupa os resultados pelo CustomerKey e trimestre
- Criar a CTE `customers_with_orders_in_quarter`
  - **Objetivo:** Identifica os clientes que fizeram pedidos em todos os quatro trimestres.
  - **Filtro (`HAVING`):** Seleciona apenas aqueles clientes que têm pedidos em 4 trimestres distintos.
  - **Agrupamento:** Agrupa pelo customerKey.
- Criar a CTE `total_orders_per_customer`
  - **Objetivo:** Conta o número total de pedidos para cada cliente que fez pedidos em todos os quatro trimestres.
  - **Filtro:** Usa a lista de clientes da CTE `customers_with_orders_in_quarter`.
  - **Agrupamento:** Agrupa pelo customerKey.
- Seleciona e Ordena o cliente com mais pedidos.

#### Item III

- **Objetivo:** Calcular o total de vendas e o valor médio de venda para cada mês e identificar o mês com o maior total de vendas, considerando apenas os meses onde o valor médio de venda é superior a 500.
- **Filtro:** Filtrar os dados para incluir apenas os meses onde o valor médio de venda é maior que 500. Isso é feito na cláusula HAVING da CTE monthly_sales.
- **Agrupamento:** Agrupa os dados por mês da venda para calcular o total de vendas  e o valor médio de venda para cada mês.

#### Item IV

- Não achei os vendedores no [Adventure Works](https://www.kaggle.com/datasets/ukveteran/adventure-works)

#### Item Extra

- **Objetivo:** Calcular o total de vendas para cada país, e identificar o território com o maior total de vendas.
- **Agrupamento:** Agrupa os dados por territoryKey e country para calcular o total de vendas para cada combinação de território e país.

### Tarefa Extra

#### Item I

- Execução da query sql
- Tratamento dos dados para o gráfico
- Plotagem dos dados
- Ajuste do modelo de Regressão linear
- Previsão de Vendas Futuras
- Plotagem da linha de Tendências
- Identificação e anotação do pico de vendas
- Configuração e exibição do gráfico

#### Item II

- Execução da query sql
- Tratamento dos dados para o gráfico
- Criação do Gráfico de Barras
- Anotação dos valores nas barras
- Ajuste do layout e Exibição do Gráfico
