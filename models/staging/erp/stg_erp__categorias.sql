with
    fonte_categorias as (
        select
            cast(ID as int) as pk_categoria
            , cast(CATEGORYNAME as varchar) as nm_categoria
            , cast(DESCRIPTION as varchar) as descricao_categoria
        from {{ source('erp', 'category') }}
    )

select *
from fonte_categorias