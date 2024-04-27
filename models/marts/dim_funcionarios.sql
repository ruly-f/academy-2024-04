with
    funcionarios as (
        select *
        from {{ ref('stg_erp__funcionarios') }}
    )

    , joined as (
        select
            funcionarios.PK_FUNCIONARIO
            , funcionarios.NM_FUNCIONARIO
            , funcionarios.CARGO_FUNCIONARIO
            , funcionarios.DT_NASCIMENTO_FUNCIONARIO
            , funcionarios.DT_CONTRATACAO
            , gerentes.NM_FUNCIONARIO as nm_gerente
            , gerentes.CARGO_FUNCIONARIO as cargo_gerente
        from funcionarios
        left join funcionarios as gerentes 
            on funcionarios.fk_gerente = gerentes.pk_funcionario
    )

select *
from joined