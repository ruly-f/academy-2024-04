with
    vendas_em_2012 as (
        select sum(valor_bruto) as total_bruto
        from {{ ref('fct_vendas') }}
        where data_do_pedido between '2012-01-01' and '2012-12-31'
    )

select total_bruto
from vendas_em_2012 -- 226298.5 esse é o valor conferido pelo time da contabilidade das vendas de 2012
where total_bruto not between 226298 and 226299