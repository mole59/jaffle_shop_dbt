
with taxiTrips as (

    select *

    from {{ ref('stg_nyctt__raw_taxi_trips') }}
),

paymentTypes as (

    select 
            paymentType
        ,   description
    from {{ ref('stg_nyctts__raw_payment_types') }}
),

rateCodes as (

    select 
            rateCode
        ,   description
    from {{ ref('stg_nyctts__raw_rate_codes') }}
),

tripTypes as (

    select 
            tripType
        ,   description
    from {{ ref('stg_nyctts__raw_trip_types') }}

),

vendors as (

    select 
            vendorId
        ,   name 
    from {{ ref('stg_nyctts__raw_vendors') }}
),

zones as (

    select 
            locationId
        ,   borough
        ,   Zone 
    from {{ ref('stg_nyctt__raw_taxi_zones') }}
),

result as (

    select 
        v.name as vendorName
    ,   tt.pickupDatetime
    ,   tt.dropoffDateTime
    ,   tt.storeAndForwardFlag
    ,   rc.description as rate 
    ,   z1.Zone as pickupZone
    ,   z1.Borough as pickupBorough
    ,   z2.Zone as dropoffZone
    ,   z2.Borough as dropoffBorough
    ,   tt.passengerCount
    ,   {{ format_numeric_columns('tt.tripDistance', 2) }} as tripDistance
    ,   {{ format_numeric_columns('tt.fareAmount', 2) }} as fareAmount
    ,   {{ format_numeric_columns('tt.extra', 2) }} as extra 
    ,   {{ format_numeric_columns('tt.mtaTax', 2) }} as mtaTax
    ,   {{ format_numeric_columns('tt.tipAmount', 2) }} as tipAmount
    ,   {{ format_numeric_columns('tt.tollsAmount', 2) }} as tollsAmount
    ,   {{ format_numeric_columns('tt.improvementSurcharge', 2) }} as improvementSurcharge
    ,   {{ format_numeric_columns('tt.totalAmount', 2) }} as totalAmount
    ,   pt.description as paymentType
    ,   tp.description as tripType

    from taxiTrips as tt 

    inner join paymentTypes as pt 
    on tt.paymentType = pt.paymentType

    inner join rateCodes as rc 
    on tt.rateCodeId = rc.rateCode 

    inner join tripTypes as tp 
    on tt.tripType = tp.tripType

    inner join vendors as v 
    on tt.vendorId = v.vendorId

    inner join zones as z1
    on tt.pickupLocationId = z1.locationId

    inner join zones as z2
    on tt.dropoffLocationId = z2.locationId

)

select *
from result