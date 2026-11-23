with 

source as (

    select * from {{ source('nyctt', 'raw_taxi_trips') }}

),

renamed as (

    select
        vendorid,
        lpep_pickup_datetime,
        lpep_dropoff_datetime,
        store_and_fwd_flag,
        ratecodeid,
        pulocationid,
        dolocationid,
        passenger_count,
        trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        total_amount,
        payment_type,
        trip_type

    from source

),

transformed as (

    select
            *
      from renamed
)

select * from transformed