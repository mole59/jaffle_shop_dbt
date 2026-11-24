with 

source as (

    select * from {{ source('nyctts', 'stg_nyctts__raw_payment_types') }}

),

renamed as (

    select
        payment_type,
        description

    from source

),

transformed as (

    select
            *
      from renamed
)

select * from transformed