with

banner_student_term_level as (select * from {{ ref('int_banner__student_term_level') }}),

banner_majors as (select * from {{ ref('dim_majors') }}),

banner_minors as (select * from {{ ref('dim_minors') }}),

banner_student_term_level_with_desc as (

  select 

    -- banner_student_term_level (driver)
    {{ dbt_utils.star(from=ref('int_banner__student_term_level'),
                      relation_alias='banner_student_term_level') }},
    maj1.major_desc                                                   as major_1_desc,
    maj2.major_desc                                                   as major_2_desc,
    maj3.major_desc                                                   as major_3_desc,
    maj4.major_desc                                                   as major_4_desc,
    min1.minor_desc                                                   as minor_1_desc,
    min2.minor_desc                                                   as minor_2_desc,
    min3.minor_desc                                                   as minor_3_desc,
    min4.minor_desc                                                   as minor_4_desc,

  from banner_student_term_level
  left join banner_majors maj1 on maj1.major_code = banner_student_term_level.major_1_code
  left join banner_majors maj2 on maj2.major_code = banner_student_term_level.major_2_code
  left join banner_majors maj3 on maj3.major_code = banner_student_term_level.major_3_code
  left join banner_majors maj4 on maj4.major_code = banner_student_term_level.major_4_code
  left join banner_minors min1 on min1.minor_code = banner_student_term_level.minor_1_code
  left join banner_minors min2 on min2.minor_code = banner_student_term_level.minor_2_code
  left join banner_minors min3 on min3.minor_code = banner_student_term_level.minor_3_code
  left join banner_minors min4 on min4.minor_code = banner_student_term_level.minor_4_code

)

select *,
       {{ dbt_utils.generate_surrogate_key(
            ['internal_banner_id',
             'term_code',
             'level_code']) }}           as ods_surrogate_key 
from banner_student_term_level_with_desc