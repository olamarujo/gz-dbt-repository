WITH grouped AS (
    SELECT 
        date_date
        , SUM(ads_cost) AS ads_cost
        , SUM(impression) AS ads_impression
        , SUM(click) AS ads_clicks
    FROM {{ ref('int_campaigns') }}
    GROUP BY date_date
)
, joined_tables AS (
    SELECT
        finance.*
        , campaign.ads_cost
        , campaign.ads_impression
        , campaign.ads_clicks
    FROM {{ ref('finance_days') }} AS finance
    INNER JOIN grouped AS campaign
    USING(date_date)
)
SELECT 
    date_date
    , operational_margin - ads_cost AS ads_margin
    , average_basket
    , operational_margin
    , ads_cost
    , ads_impression 
    , ads_clicks
    , nb_transactions AS quantity
    , revenue
    , margin
FROM joined_tables