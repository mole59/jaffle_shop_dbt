with revenue as (

    select sum(payment_amount) as total_revenue
    from {{ ref('stg_classic__raw_payments') }}
    where payment_status = 'success'

)

select total_revenue from revenue