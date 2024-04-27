with
    fonte_ordem_detalhes as (
        select
            cast(orderid as int) as fk_pedido
            , cast(productid as int) as fk_produto
            , cast(discount as numeric(18,2)) as desconto_perc
            , cast(unitprice as numeric(18,2)) as preco_da_unidade
            , cast(quantity as int) as quantidade
        from {{ source('erp', 'orderdetail') }}
    )

select *
from fonte_ordem_detalhes