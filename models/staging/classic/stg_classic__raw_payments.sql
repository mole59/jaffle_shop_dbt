with 

source as (

    select * from {{ source('classic', 'raw_payments') }}

),

renamed as (

    select
        id AS payment_id,
        order_id,
        payment_method,
        amount

    from source

)

select * from renamed