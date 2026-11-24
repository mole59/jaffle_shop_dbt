with taxi_trips as (

    select *

    from {{ ref('stg_nyctt__raw_taxi_trips') }}
),

payment_types as (

    select 
            payment_type
        ,   description
    from {{ ref('stg_nyctts__raw_payment_types') }}
),

rate_codes as (

    select 
            rate_code
        ,   description
    from {{ ref('stg_nyctts__raw_rate_codes') }}
),

trip_types as (

    select 
            trip_type
        ,   description
    from {{ ref('stg_nyctts__raw_trip_types') }}

),

vendors as (

    select 
            vendorid
        ,   name 
    from {{ ref('stg_nyctts__raw_vendors') }}
),

result as (

    select 
        v.name as vendorName
    ,   tt.lpep_pickup_datetime
    ,   tt.lpep_dropoff_datetime
    ,   tt.store_and_fwd_flag
    ,   rc.description as rate 
    ,   tt.pulocationid
    ,   tt.dolocationid
    ,   tt.passenger_count
    ,   tt.trip_distance
    ,   tt.fare_amount
    ,   tt.extra 
    ,   tt.mta_tax
    ,   tt.total_amount
    ,   tt.tolls_amount
    ,   tt.improvement_surcharge
    ,   tt.total_amount
    ,   pt.description as paymentType
    ,   tp.description as tripType

    from taxi_trips as tt 

    inner join payment_types as pt 
    on tt.payment_type = pt.payment_type

    inner join rate_codes as rc 
    on tt.ratecodeid = rc.rate_code 

    inner join trip_types as tp 
    on tt.trip_type = tp.trip_type

    inner join vendors as v 
    on tt.vendorid = v.vendorid

)

select *
from result