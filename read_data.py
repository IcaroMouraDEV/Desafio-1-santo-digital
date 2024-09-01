import mysql.connector
import pandas as pd

mysql = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="adventure_works_cycles"
)

cursor = mysql.cursor();

def top_ten_bicycles():
  query = """
    SELECT sale.product_id, SUM(sale.order_quantity) as qtd
    FROM sale
    LEFT JOIN product ON sale.product_id = product.id
    LEFT JOIN product_subcategory ON product.subcategory_id = product_subcategory.id
    WHERE category_id = 1 AND order_date >= '2016/01/01'
    GROUP BY product_id
    ORDER BY qtd DESC
    LIMIT 10 
  """;

  cursor.execute(query)
  data = cursor.fetchall();
  header = ['ProductKey', 'TotalSales']
  df = pd.DataFrame(data, columns=header)
  
  df.to_csv('data/output/top_ten_bicycles.csv', index=False)

def best_customer():
  query = """
    WITH orders_per_quarter AS (
      SELECT customer_id, QUARTER(order_date) AS quarter, COUNT(id) as qtd
      FROM sale
      WHERE order_date BETWEEN '2016-01-01' AND '2017-6-30'
      GROUP BY customer_id, QUARTER(order_date)
    ),
    customers_with_orders_in_quarter AS (
      SELECT customer_id
      FROM orders_per_quarter
      GROUP BY customer_id
      HAVING COUNT(DISTINCT quarter) = 4
    ),
    total_orders_per_customer AS (
      SELECT s.customer_id, COUNT(s.id) AS total_orders
      FROM sale AS s
      WHERE s.customer_id IN (SELECT customer_id FROM customers_with_orders_in_quarter)
      GROUP BY s.customer_id
    )
    SELECT customer_id, total_orders
    FROM total_orders_per_customer
    ORDER BY total_orders DESC
    LIMIT 1
  """;

  cursor.execute(query)
  data = cursor.fetchall();
  header = ['CustomerKey', 'TotalSales']
  df = pd.DataFrame(data, columns=header)
  
  df.to_csv('data/output/best_customer.csv', index=False)

  print(data)

def best_month():
  query = """
    WITH monthly_sales AS (
    SELECT 
      MONTH(order_date) AS sale_month,
      SUM(order_quantity * product.price) AS total_sales,
      AVG(order_quantity * product.price) AS avg_sale_value 
    FROM sale
    JOIN product ON sale.product_id = product.id
    GROUP BY MONTH(order_date)
    HAVING AVG(order_quantity * product.price) > 500
    )
    SELECT 
      sale_month, 
      total_sales
    FROM monthly_sales
    ORDER BY total_sales DESC
    LIMIT 1;
  """

  cursor.execute(query)
  data = cursor.fetchall();
  header = ['SaleMonth', 'TotalSales']
  df = pd.DataFrame(data, columns=header)
  
  df.to_csv('data/output/best_month.csv', index=False)

  print(data)

def best_territory():
  query = """
    SELECT
      t.id AS territory_id,
      c.name AS country,
      SUM(s.order_quantity * p.price) AS total_sales
    FROM adventure_works_cycles.sale AS s
    JOIN adventure_works_cycles.product AS p ON s.product_id = p.id
    JOIN adventure_works_cycles.territory AS t ON s.territory_id = t.id
    JOIN adventure_works_cycles.territory_country AS c ON t.country_id = c.id
    GROUP BY t.id, c.name
    ORDER BY total_sales DESC
    LIMIT 1;
  """

  cursor.execute(query)
  data = cursor.fetchall();
  header = ['TerritoryId', 'TerritoryName','TotalSales']
  df = pd.DataFrame(data, columns=header)
  
  df.to_csv('data/output/best_territory.csv', index=False)

  print(data)

cursor.close()
mysql.close()
