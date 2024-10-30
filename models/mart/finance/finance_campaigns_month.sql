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
    EXTRACT(month FROM date_date) AS month
    , SUM(operational_margin - ads_cost) AS ads_margin
    , SUM(average_basket) AS average_basket
    , SUM(operational_margin) AS operational_margin
    , SUM(ads_cost) AS ads_cost
    , SUM(ads_impression) AS ads_impression
    , SUM(ads_clicks) AS ads_clicks
    , SUM(nb_transactions) AS quantity
    , SUM(revenue) AS revenue
    , SUM(margin) AS margin
FROM joined_tables
GROUP BY month