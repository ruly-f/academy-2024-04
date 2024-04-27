with
    pedido_por_itens as (
        select *
        from {{ ref('int_pedido_por_itens') }}
    )

    , dim_produtos as (
        select *
        from {{ ref('dim_produtos') }}
    )

    , dim_funcionarios as (
        select *
        from {{ ref('dim_funcionarios') }}
    )

    , joined as (
        select
            fatos.sk_vendas
            , fatos.FK_PEDIDO as numero_nota_fiscal
            , fatos.FK_PRODUTO
            , fatos.FK_FUNCIONARIO
            , fatos.FK_CLIENTE
            , fatos.FK_TRANSPORTADORA
            , fatos.DESCONTO_PERC
            , fatos.PRECO_DA_UNIDADE
            , fatos.QUANTIDADE
            , fatos.DATA_DO_PEDIDO
            , fatos.FRETE
            , fatos.NM_DESTINATARIO
            , fatos.CIDADE_DESTINATARIO
            , fatos.REGIAO_DESTINATARIO
            , fatos.PAIS_DESTINATARIO
            , fatos.DATA_DO_ENVIO
            , fatos.DATA_REQUERIDA_ENTREGA
            , dim_produtos.NM_PRODUTO
            , dim_produtos.IS_DISCONTINUADO
            , dim_produtos.NM_CATEGORIA
            , dim_produtos.DESCRICAO_CATEGORIA
            , dim_produtos.NM_FORNECEDOR
            , dim_produtos.CIDADE_FORNECEDOR
            , dim_produtos.PAIS_FORNECEDOR
            , dim_funcionarios.NM_FUNCIONARIO
            , dim_funcionarios.CARGO_FUNCIONARIO
            , dim_funcionarios.DT_CONTRATACAO
            , dim_funcionarios.NM_GERENTE
        from pedido_por_itens as fatos
        left join dim_produtos on fatos.fk_produto = dim_produtos.pk_produto
        left join dim_funcionarios on fatos.fk_funcionario = dim_funcionarios.pk_funcionario
    )

    , metricas as (
        select
            sk_vendas
            , FK_PRODUTO
            , FK_FUNCIONARIO
            , FK_CLIENTE
            , FK_TRANSPORTADORA
            , numero_nota_fiscal
            , DESCONTO_PERC
            , PRECO_DA_UNIDADE
            , QUANTIDADE
            , DATA_DO_PEDIDO
            , DATA_DO_ENVIO
            , DATA_REQUERIDA_ENTREGA
            , NM_DESTINATARIO
            , CIDADE_DESTINATARIO
            , REGIAO_DESTINATARIO
            , PAIS_DESTINATARIO
            , NM_PRODUTO
            , IS_DISCONTINUADO
            , NM_CATEGORIA
            , DESCRICAO_CATEGORIA
            , NM_FORNECEDOR
            , CIDADE_FORNECEDOR
            , PAIS_FORNECEDOR
            , NM_FUNCIONARIO
            , CARGO_FUNCIONARIO
            , DT_CONTRATACAO
            , NM_GERENTE
            , quantidade * preco_da_unidade as valor_bruto
            , quantidade * (1 - desconto_perc) * preco_da_unidade as valor_liquido
            , cast(
                (dt_contratacao - data_do_pedido) / 365 
                as numeric(18,2)
            )  as senioridade_em_anos
            , cast(
                frete / count(numero_nota_fiscal) over (partition by numero_nota_fiscal)
                as numeric(18,2)
            ) as frete_rateado
        from joined
    )

select *
from metricas
