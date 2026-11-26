with 

source as (

    select * from {{ source('nyctts', 'raw_rate_codes') }}

),

renamed as (

    select
        rate_code as rateCode,
        description

    from source

),

transformed as (

    select
            *
      from renamed
)

select * from transformed