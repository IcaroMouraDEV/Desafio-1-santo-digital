CREATE SCHEMA IF NOT EXISTS adventure_works_cycles;

CREATE TABLE IF NOT EXISTS adventure_works_cycles.product_color(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) UNIQUE KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.product_size(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) UNIQUE KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.product_style(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) UNIQUE KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.product_model(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  description VARCHAR(500) NOT NULL,
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.product_category(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) UNIQUE KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.product_subcategory(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  category_id INT NOT NULL,
  name VARCHAR(20) UNIQUE KEY NOT NULL,

  CONSTRAINT fk_category_subcategory FOREIGN KEY (category_id)
    REFERENCES adventure_works_cycles.product_category(id)
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.product(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  color_id INT NOT NULL,
  model_id INT NOT NULL,
  size_id INT NOT NULL,
  style_id INT NOT NULL,
  subcategory_id INT NOT NULL,
  sku VARCHAR(50) UNIQUE KEY NOT NULL,
  name VARCHAR(50) NOT NULL,
  price DECIMAL(12,4) NOT NULL,
  cost DECIMAL(12,4) NOT NULL,

  CONSTRAINT fk_color_product FOREIGN KEY (color_id)
    REFERENCES adventure_works_cycles.product_color(id),
  CONSTRAINT fk_model_product FOREIGN KEY (model_id)
    REFERENCES adventure_works_cycles.product_model(id),
  CONSTRAINT fk_size_product FOREIGN KEY (size_id)
    REFERENCES adventure_works_cycles.product_size(id),
  CONSTRAINT fk_style_product FOREIGN KEY (style_id)
    REFERENCES adventure_works_cycles.product_style(id),
  CONSTRAINT fk_subcategory_product FOREIGN KEY (subcategory_id)
    REFERENCES adventure_works_cycles.product_subcategory(id)
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.territory_country(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) UNIQUE KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.territory_continent(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) UNIQUE KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.territory_region(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) UNIQUE KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.territory(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  country_id INT NOT NULL,
  continent_id INT NOT NULL,
  region_id INT NOT NULL,

  CONSTRAINT fk_country_territory FOREIGN KEY (country_id)
    REFERENCES adventure_works_cycles.territory_country(id),
  CONSTRAINT fk_continent_territory FOREIGN KEY (continent_id)
    REFERENCES adventure_works_cycles.territory_continent(id),
  CONSTRAINT fk_region_territory FOREIGN KEY (region_id)
    REFERENCES adventure_works_cycles.territory_region(id)
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.products_return(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  product_id INT NOT NULL,
  territory_id INT NOT NULL,
  `date` DATE NOT NULL, 
  quantity INT NOT NULL,

  CONSTRAINT fk_product_return FOREIGN KEY (product_id)
    REFERENCES adventure_works_cycles.product(id),
  CONSTRAINT fk_territory_return FOREIGN KEY (territory_id)
    REFERENCES adventure_works_cycles.territory(id)
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.calendar(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `date` DATE  NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.customer_education_level(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) UNIQUE KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.customer_gender(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) UNIQUE KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.customer_marital_status(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) UNIQUE KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.customer_occupation(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) UNIQUE KEY NOT NULL
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.customer_prefix(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(20) UNIQUE KEY
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.customer(
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  education_level_id INT NOT NULL,
  gender_id INT NOT NULL,
  marital_status_id INT NOT NULL,
  occupation_id INT NOT NULL,
  prefix_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  birth_date DATE NOT NULL,
  email VARCHAR(100) NOT NULL,
  annual_income DECIMAL(12,2),
  total_children INT NOT NULL,
  home_owner VARCHAR(20) NOT NULL,

  CONSTRAINT fk_education_level_customer FOREIGN KEY (education_level_id)
    REFERENCES adventure_works_cycles.customer_education_level(id),
  CONSTRAINT fk_gender_customer FOREIGN KEY (gender_id)
    REFERENCES adventure_works_cycles.customer_gender(id),
  CONSTRAINT fk_marital_status_customer FOREIGN KEY (marital_status_id)
    REFERENCES adventure_works_cycles.customer_marital_status(id),
  CONSTRAINT fk_occupation_customer FOREIGN KEY (occupation_id)
    REFERENCES adventure_works_cycles.customer_occupation(id),
  CONSTRAINT fk_prefix_customer FOREIGN KEY (prefix_id)
    REFERENCES adventure_works_cycles.customer_prefix(id)
);

CREATE TABLE IF NOT EXISTS adventure_works_cycles.sale(
  id INT NOT NULL PRIMARY KEY,
  code VARCHAR(10) NOT NULL,
  customer_id INT NOT NULL,
  product_id INT NOT NULL,
  territory_id INT NOT NULL,
  order_date DATE NOT NULL,
  order_line_item INT NOT NULL,
  order_quantity INT NOT NULL,
  stock_date DATE NOT NULL,

  CONSTRAINT fk_customer_sale FOREIGN KEY (customer_id)
    REFERENCES adventure_works_cycles.customer(id),
  CONSTRAINT fk_product_sale FOREIGN KEY (product_id)
    REFERENCES adventure_works_cycles.product(id),
  CONSTRAINT fk_territory_sale FOREIGN KEY (territory_id)
    REFERENCES adventure_works_cycles.territory(id)
);
