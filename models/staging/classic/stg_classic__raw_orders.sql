with 

source as (

    select * from {{ source('classic', 'raw_orders') }}

),

renamed as (

    select
        id AS order_id,
        user_id AS customer_id,
        order_date,
        status

    from source

)

select * from renamed