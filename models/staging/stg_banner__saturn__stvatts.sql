with source as (

    select * from {{ source('banner__saturn', 'stvatts') }}

),

renamed as (

    select
        stvatts_code,
        stvatts_desc,
        stvatts_activity_date,
        stvatts_surrogate_id,
        stvatts_version,
        stvatts_user_id,
        stvatts_data_origin,
        stvatts_vpdi_code

    from source

)

select * from renamed