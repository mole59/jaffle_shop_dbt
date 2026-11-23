with 

source as (

    select * from {{ source('nyctts', 'raw_vendors') }}

),

renamed as (

    select
        vendorid,
        name,
        location

    from source

),

transformed as (

    select
            *
      from renamed
)

select * from transformed