WITH joined_tables AS (
    SELECT
        sales.*
        , ship.shipping_fee
        , ship.logcost
        , ship.ship_cost
    FROM {{ ref('int_sales_margin') }} AS sales
    LEFT JOIN {{ ref('stg_raw__ship') }} AS ship
    USING(orders_id)
)
SELECT 
    date_date
    , COUNT(orders_id) AS nb_transactions
    , SUM(revenue) AS revenue
    , AVG(revenue) AS average_basket
    , SUM(margin) AS margin
    , SUM(margin + shipping_fee - logcost - ship_cost) AS operational_margin
FROM joined_tables
GROUP BY date_date