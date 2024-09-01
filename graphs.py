import matplotlib.pyplot as plt
import mysql.connector
import numpy as np
from sklearn.linear_model import LinearRegression
from datetime import timedelta

mysql = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="adventure_works_cycles"
)

def sales_by_month():
  cursor = mysql.cursor();
  query = """
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(order_quantity) as total_sales
    FROM sale
    GROUP BY month
    ORDER BY month ASC
  """
  
  cursor.execute(query)
  data = cursor.fetchall();

  cursor.close()

  months = [row[0] for row in data];
  total_sales = [row[1] for row in data];

  plt.plot(months, total_sales, marker='o', linestyle='-', color='green');
  plt.xlabel('Meses');
  plt.ylabel('Vendas Mensais');
  plt.title('Tendencia de Vendas Mensais')

  X = np.arange(len(months)).reshape(-1, 1)  # Meses como valores numéricos
  y = np.array(total_sales)
  model = LinearRegression().fit(X, y)
  
  future_months = np.arange(len(months) + 6).reshape(-1, 1)
  future_sales = model.predict(future_months)

  plt.plot(future_months, future_sales, linestyle='--', color='orange', label='Trend Line')

  max_sales = max(total_sales)
  peak_months = [month for month, sales in zip(months, total_sales) if sales == max_sales]

  for month in peak_months:
    plt.annotate('Pico', xy=(month, max_sales), xytext=(month, max_sales + 150), color='red')
    plt.scatter(month, max_sales, color='red', zorder=5)

  plt.xticks(rotation=90)
  plt.tight_layout()
  plt.show()

def top_ten_bikes():
  cursor = mysql.cursor();
  query = """
    SELECT
      product.name,
      SUM(sale.order_quantity) AS qtd,
      (product.price - product.cost) * SUM(sale.order_quantity) AS profit
    FROM sale
    LEFT JOIN product ON sale.product_id = product.id
    LEFT JOIN product_subcategory ON product.subcategory_id = product_subcategory.id
    WHERE category_id = 1 AND order_date >= '2016/01/01'
    GROUP BY product_id
    ORDER BY qtd ASC
    LIMIT 10 
  """;

  cursor.execute(query)
  data = cursor.fetchall();

  print(data)

  cursor.close()

  products = [row[0] for row in data]
  quantity_sold = [row[1] for row in data]
  profit = [row[2] for row in data]

  _, ax = plt.subplots(figsize=(14, 8))

  bar_width = 0.35
  index = range(len(products))

  bars1 = ax.bar(index, quantity_sold, bar_width, label='Quantity Sold', color='blue')
  bars2 = ax.bar([i + bar_width for i in index], profit, bar_width, label='Profit', color='green')

  ax.set_xlabel('Product')
  ax.set_ylabel('Values')
  ax.set_title('Top 10 Best-Selling Products in the "Bikes" Category')
  # ax.set_xticks([i + bar_width / 2 for i in index])
  ax.set_xticklabels(products, rotation=90, ha='right')
  ax.legend()

  for bar in bars1:
    height = bar.get_height()
    ax.text(bar.get_x() + bar.get_width() / 2., height + 50, f'{height}', ha='center', va='bottom', color='black')

  for bar in bars2:
    height = bar.get_height()
    ax.text(bar.get_x() + bar.get_width() / 2., height + 50, f'${height:,.2f}', ha='center', va='bottom', color='black')

  plt.tight_layout()
  plt.show()

