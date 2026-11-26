with 

source as (

    select * from {{ source('nyctts', 'raw_payment_types') }}

),

renamed as (

    select
        payment_type as paymentType,
        description

    from source

),

transformed as (

    select *
    from renamed
)

select * from transformed