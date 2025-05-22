-- RESPUESTA 1
-1. Listar los usuarios que cumplan años el día de hoy cuya cantidad de ventas realizadas en enero 2020 sea superior a 1500. 

SELECT
  seller.CustomerID      AS seller_id,
  seller.first_name      AS seller_first_name,
  seller.last_name       AS seller_last_name,
  SUM(ord.total_amt)     AS january_2020_sales
FROM `mercado_libre.dataset.Order` AS ord
JOIN `mercado_libre.dataset.Customer` AS seller
  ON ord.SellerID = seller.CustomerID
WHERE
  EXTRACT(MONTH FROM seller.birth_date) = EXTRACT(MONTH  FROM CURRENT_DATE())
  AND EXTRACT(DAY   FROM seller.birth_date) = EXTRACT(DAY    FROM CURRENT_DATE())
  AND ord.order_month = DATE '2020-01-01'
GROUP BY
  seller.CustomerID,
  seller.first_name,
  seller.last_name
HAVING
  SUM(ord.total_amt) > 1500
ORDER BY
  january_2020_sales DESC;


-- RESPUESTA 2

2. Por cada mes del 2020, se solicita el top 5 de usuarios que más vendieron($) en la categoría Celulares. Se requiere el mes y año de análisis, nombre y apellido del vendedor, cantidad de ventas realizadas, cantidad de productos vendidos y el monto total transaccionado. 

SELECT
  ord.order_month                    AS analysis_month,      
  seller.first_name                  AS seller_first_name,
  seller.last_name                   AS seller_last_name,
  COUNT(ord.OrdID)                   AS total_orders,        
  SUM(ord.quantity)                  AS total_products,      
  SUM(ord.total_amt)                 AS total_revenue       
FROM `mercado_libre.dataset.Order` AS ord
JOIN `mercado_libre.dataset.Customer` AS seller
  ON ord.SellerID = seller.CustomerID
WHERE
  ord.order_month BETWEEN DATE '2020-01-01' AND DATE '2020-12-01' 
  AND ord.CatID = celulares_cat_id    -- ID ficticio de categoría celulares 
GROUP BY
  ord.order_month,
  seller.first_name,
  seller.last_name
QUALIFY
  ROW_NUMBER() OVER (
    PARTITION BY ord.order_month
    ORDER BY total_revenue DESC
  ) <= 5
ORDER BY
  ord.order_month,
  total_revenue DESC;


-- RESPUESTA 3
3. Se solicita poblar una nueva tabla con el precio y estado de los Ítems a fin del día. Tener en cuenta que debe ser reprocesable. Vale resaltar que en la tabla Item, vamos a tener únicamente el último estado informado por la PK definida. (Se puede resolver a través de StoredProcedure) 

CREATE OR REPLACE PROCEDURE `mercado_libre.dataset.put_item_status_history`(
  IN fecha_a_procesar DATE    -- fecha a reprocesar; si es NULL, usa el día anterior
)
BEGIN
  DECLARE fecha DATE
    DEFAULT IF(
      fecha_a_procesar IS NULL,
      DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY),
      fecha_a_procesar
    );

  DELETE
  FROM `mercado_libre.dataset.Item_Status_History`
  WHERE hist_dt = fecha;

  INSERT INTO `mercado_libre.dataset.Item_Status_History` (
    ItemID,
    status,
    price,
    hist_dt
  )
  SELECT
    ItemID,
    status,
    price,
    fecha
  FROM `mercado_libre.dataset.Item`;
END;