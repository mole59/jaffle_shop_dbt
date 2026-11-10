with 

source as (

    select * from {{ source('classic', 'raw_customer') }}

),

renamed as (

    select
        id AS customer_id,
        first_name,
        last_name

    from source

)

select * from renamed