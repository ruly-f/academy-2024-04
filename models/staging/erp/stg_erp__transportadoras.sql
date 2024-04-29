with
    fonte_transportadoras as (
        select 
            cast(ID as int) as pk_transportadora
            , cast(COMPANYNAME as varchar) as nm_transportadora
        from {{ source('erp', 'shipper') }}
    )

select *
from fonte_transportadoras
