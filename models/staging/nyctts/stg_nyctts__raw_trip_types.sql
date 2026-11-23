with 

source as (

    select * from {{ source('nyctts', 'raw_trip_types') }}

),

renamed as (

    select
        trip_type,
        description

    from source

),

transformed as (

    select
            *
      from renamed
)

select * from transformed