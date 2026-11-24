with taxi_trips as (

    select *

    from ref('stg_nyctt__raw_taxi_trips')
)


select *
from taxi_trips