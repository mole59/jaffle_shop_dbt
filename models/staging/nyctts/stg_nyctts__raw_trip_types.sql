with 

source as (

    select * from {{ source('nyctts', 'raw_trip_types') }}

),

renamed as (

    select

    from source

),

transformed as (

    select
            *
      from renamed
)

select * from transformed