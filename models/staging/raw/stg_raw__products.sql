with 

source as (

    select * from {{ source('raw', 'products') }}

),

renamed as (

    select
        products_id
        , purchse_price AS purchase_price
    from source

)

select * from renamed
