with 

source as (

    select * from {{ source('nyctt', 'raw_taxi_trips') }}

),

renamed as (

    select
        vendorid as vendorId,
        lpep_pickup_datetime as pickupDatetime,
        lpep_dropoff_datetime as dropoffDateTime,
        store_and_fwd_flag as storeAndForwardFlag,
        ratecodeid as rateCodeId,
        pulocationid as pickupLocationId,
        dolocationid as dropoffLocationId,
        passenger_count as passengerCount,
        trip_distance as tripDistance,
        fare_amount as fareAmount,
        extra,
        mta_tax as mtaTax,
        tip_amount as tipAmount,
        tolls_amount as tollsAmount,
        improvement_surcharge as improvementSurcharge,
        total_amount as totalAmount,
        payment_type as paymentType,
        trip_type as tripType

    from source

),

transformed as (

    select
            *
      from renamed
)

select * from transformed