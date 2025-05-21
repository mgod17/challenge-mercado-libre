CREATE TABLE `mercado_libre.dataset.Customer` (
  CustomerID   INT64,
  first_name   STRING   NOT NULL,
  last_name    STRING   NOT NULL,
  email        STRING   NOT NULL,
  gender       STRING(1),
  address      STRING,
  birth_date   DATE,
  phone        STRING
);

CREATE TABLE `mercado_libre.dataset.Category` (
  CatID        INT64,
  name         STRING   NOT NULL,
  path         STRING   NOT NULL,
  description  STRING
);

CREATE TABLE `mercado_libre.dataset.Item` (
  ItemID       INT64,
  CatID        INT64,    
  SellerID     INT64,   
  price        NUMERIC,
  status       STRING,
  inactive_dt  DATE
);

CREATE TABLE `mercado_libre.dataset.Order` (
  OrdID        INT64,
  BuyerID      INT64,    
  ItemID       INT64,   
  SellerID     INT64,    
  CatID        INT64,    
  order_dt     DATETIME,
  order_month  DATE,     
  quantity     INT64,
  total_amt    NUMERIC
)
PARTITION BY order_month;

CREATE TABLE `mercado_libre.dataset.Item_Status_History` (
  ItemID      INT64,
  status      STRING,
  price       NUMERIC,
  hist_dt     DATE      
)
PARTITION BY hist_dt;
