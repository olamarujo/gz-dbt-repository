with 

source as (

    select * from {{ source('raw', 'sales') }}

),

renamed as (

    select
        date_date,
        orders_id,
        CAST(pdt_id AS FLOAT64) AS products_id,
        revenue,
        quantity

    from source

)

select * from renamed
