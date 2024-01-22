with source as (

    select * from {{ source('banner__saturn', 'stvastd') }}

),

renamed as (

    select
        stvastd_code,
        stvastd_desc,
        stvastd_probation_ind,
        stvastd_prevent_reg_ind,
        stvastd_max_reg_hours,
        stvastd_activity_date,
        stvastd_deans_list_ind,
        stvastd_system_req_ind,
        stvastd_short_desc,
        stvastd_edi_equiv,
        stvastd_vr_msg_no,
        stvastd_min_reg_hours,
        stvastd_surrogate_id,
        stvastd_version,
        stvastd_user_id,
        stvastd_data_origin,
        stvastd_vpdi_code

    from source

)

select * from renamed