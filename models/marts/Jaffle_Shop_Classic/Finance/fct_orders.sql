{{
    config(
        materialized='incremental'
    )
}}

with orders as (

    select * from {{ ref('stg_classic__raw_orders') }}

),

payments as (

    select * from {{ ref('stg_classic__raw_payments') }}

),

order_payments as (

    select 
            order_id
        ,   sum(case when payment_status = 'success' then payment_amount end) as payment_amount    
    from payments
    group by 1
),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        coalesce(order_payments.payment_amount, 0) as payment_amount

    from orders

    left join order_payments using (order_id)

)

select * from final
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where order_date > (select max(order_date) from {{ this }}) 
{% endif %}
order by order_date desc