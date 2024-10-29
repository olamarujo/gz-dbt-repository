WITH joined_tables AS(
SELECT
    sales.*
    , products.purchase_price
FROM {{ ref('stg_raw__sales') }} AS sales
LEFT JOIN {{ ref('stg_raw__products') }} AS products
USING (products_id)
)
SELECT
    *
    , revenue - purchase_price AS margin
FROM joined_tables