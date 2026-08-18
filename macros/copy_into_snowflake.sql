{% macro macros_copy_csv(table_name) %}
    delete from {{var('db_name')}}.{{var('schema_name')}}.{{table_name}}
    COPY INTO {{var('db_name')}}.{{var('schema_name')}}.{{table_name}}
    FROM
    (
        SELECT

    $1 AS ProductId,

    $2 AS ProductName,

    $3 AS Category,

    $4 AS SellingPrice,

    $5 AS ModelNumber,

    $6 AS AboutProduct,

    $7 AS ProductSpecification,

    $8 AS TechnicalDetails,

    $9 AS ShippingWeight,

    $10 AS ProductDimensions,
    CURRENT_TIMESTAMP() AS INSERT_DTS,
    CURRENT_TIMESTAMP() AS UPDATE_DTS,
    metadata$filename() as SOURCE_FILE_NAME,
    metadata$file_row_number() as SOURCE_FILE_ROW_NUMBER
    FROM @{{var('stage_name')}}
    )
    FILE_FORMAT = {{var('stage_name')}}
    PURGE = {{var('purge_status')}}
    FORCE = TRUE
    ;
{% endmacro %}