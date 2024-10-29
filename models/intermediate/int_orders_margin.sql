WITH joined_tables AS (
SELECT
    margin.*
    , ship.shipping_fee
    , ship.logcost
    , ship.ship_cost
FROM {{ ref('int_sales_margin') }} AS margin
LEFT JOIN {{ ref('stg_raw__ship') }} AS ship
USING(orders_id)
)
SELECT
    *
    , margin + shipping_fee - logcost - ship_cost AS operational_margin
FROM joined_tables