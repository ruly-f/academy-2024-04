with
    fonte_funcionarios as (
        select
            cast(id as int) as pk_funcionario
            , cast(reportsto as int) as fk_gerente -- Coluna "reportsto" é o id que o funcionário tem que de superior
            , cast(firstname as string) || ' ' || cast(lastname as string) as nm_funcionario
            , cast(title as string) as cargo_funcionario
            , cast(birthdate as date) as dt_nascimento_funcionario
            , cast(hiredate as date) as dt_contratacao
        from {{ source('erp', 'employee') }}
    )

select *
from fonte_funcionarios