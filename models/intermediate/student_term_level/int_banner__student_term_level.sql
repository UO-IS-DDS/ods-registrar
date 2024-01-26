with

banner_student_term_level as (select * from {{ ref('stg_banner__saturn__sgbstdn') }}),

-- relationships_int_banner__student_term_level_internal_banner_id__internal_banner_id__ref_mart_persons
-- relationships_int_banner__student_term_level_major_%_code__major_code__ref_dim_majors
-- relationships_int_banner__student_term_level_minor_%_code__minor_code__ref_dim_minors
test_clean as (

  select *
  from banner_student_term_level t1
  where t1.internal_banner_id in (
                                   select t2.internal_banner_id
                                   from {{ ref('cln_dim_persons') }} t2
                                 )
    and not exists (
                     (
                       select t1.major_1_code union
                       select t1.major_2_code union
                       select t1.major_3_code union
                       select t1.major_4_code
                     )

                     except

                     (
                       select major_code
                       from {{ ref('cln_dim_majors') }}
                     )
                   )
   and not exists (
                     (
                       select t1.minor_1_code union
                       select t1.minor_2_code union
                       select t1.minor_3_code union
                       select t1.minor_4_code
                     )

                     except

                     (
                       select minor_code
                       from {{ ref('cln_dim_minors') }}
                     )
                   )
)    

select *,
       {{ dbt_utils.generate_surrogate_key(
            ['internal_banner_id',
             'term_code',
             'level_code']) }}           as ods_surrogate_key 
from test_clean