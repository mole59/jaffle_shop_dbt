with 

source as (

    select * from {{ source('classic', 'raw_employees') }}

),

renamed as (

    select
        employee_id, 
        email, 
        customer_id

    from source

)

select * from renamed