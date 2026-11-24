
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

zones as (

    select 
            LocationID
        ,   Borough
        ,   Zone 
    from {{ ref('stg_nyctt__raw_taxi_zones') }}
),

result as (

    select 
        v.name as vendorName
    ,   tt.lpep_pickup_datetime
    ,   tt.lpep_dropoff_datetime
    ,   tt.store_and_fwd_flag
    ,   rc.description as rate 
    ,   z1.Zone as pickupZone
    ,   z1.Borough as pickupBorough
    ,   z2.Zone as dropoffZone
    ,   z2.Borough as dropoffBorough
    ,   tt.passenger_count
    ,   tt.trip_distance
    ,   {{ format_numeric_columns('tt.fare_amount', 2) }} as fare_amount
    ,   {{ format_numeric_columns('tt.extra', 2) }} as extra 
    ,   {{ format_numeric_columns('tt.mta_tax', 2) }} as mta_tax
    ,   {{ format_numeric_columns('tt.tip_amount', 2) }} as top_amount
    ,   {{ format_numeric_columns('tt.tolls_amount', 2) }} as tolls_amount
    ,   {{ format_numeric_columns('tt.improvement_surcharge', 2) }} as improvement_surcharge
    ,   {{ format_numeric_columns('tt.total_amount', 2) }} as total_amount
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

    inner join zones as z1
    on tt.pulocationid = z1.LocationID

    inner join zones as z2
    on tt.dolocationid = z2.LocationID

)

select *
from result