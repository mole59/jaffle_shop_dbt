with 

source as (

    select * from {{ source('nyctt', 'raw_454_calendar') }}

),

renamed as (

    select
        date,
        fiscalyear,
        fiscalquarter,
        fiscalmonthnumber,
        fiscalmonthofquarter,
        fiscalweekofyear,
        dayofweek,
        fiscalmonthname,
        fiscalmonthyear,
        fiscalquarteryear,
        dayofmonthnumber,
        dayname

    from source

),

transformed as (

    select
            *
      from renamed
)

select * from transformed