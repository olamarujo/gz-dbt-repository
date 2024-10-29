WITH joined_tables AS (
SELECT
    margin.orders_id
    , margin.date_date
    , margin.margin
    , IF(ship.shipping_fee  IS NULL, 0, ship.shipping_fee) AS shipping_fee
    , IF(ship.logcost IS NULL, 0 , ship.logcost) AS logcost
    , IF(ship.ship_cost IS NULL , 0 , ship.ship_cost) AS ship_cost
FROM {{ ref('int_sales_margin') }} AS margin
LEFT JOIN {{ ref('stg_raw__ship') }} AS ship
USING(orders_id)
)
SELECT
    orders_id
    , date_date
    , margin + shipping_fee - logcost - ship_cost AS operational_margin
FROM joined_tables
ORDER BY ship_cost ASC