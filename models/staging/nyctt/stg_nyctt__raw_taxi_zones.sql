with 

source as (

    select * from {{ source('nyctt', 'raw_taxi_zones') }}

),

renamed as (

    select
        locationid,
        borough,
        zone,
        service_zone

    from source

),

transformed as (

    select
            *
      from renamed
)

select * from transformed