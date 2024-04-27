with
    ordens as (
        select *
        from {{ ref('stg_erp__ordens') }}
    )

    , ordem_detalhes as (
        select *
        from {{ ref('stg_erp__ordem_detalhes') }}
    )

    , joined as (
        select
            ordem_detalhes.FK_PEDIDO
            , ordem_detalhes.FK_PRODUTO
            , ordens.FK_FUNCIONARIO
            , ordens.FK_CLIENTE
            , ordens.FK_TRANSPORTADORA
            , ordem_detalhes.DESCONTO_PERC
            , ordem_detalhes.PRECO_DA_UNIDADE
            , ordem_detalhes.QUANTIDADE
            , ordens.DATA_DO_PEDIDO
            , ordens.FRETE
            , ordens.NM_DESTINATARIO
            , ordens.CIDADE_DESTINATARIO
            , ordens.REGIAO_DESTINATARIO
            , ordens.PAIS_DESTINATARIO
            , ordens.DATA_DO_ENVIO
            , ordens.DATA_REQUERIDA_ENTREGA
        from ordem_detalhes
        left join ordens on ordem_detalhes.fk_pedido = ordens.pk_pedido
    )

    , criada_chave_primaria as (
        select
            cast(FK_PEDIDO as varchar) || '-' || FK_PRODUTO::varchar as sk_vendas
            , *
        from joined
    )

select *
from criada_chave_primaria
