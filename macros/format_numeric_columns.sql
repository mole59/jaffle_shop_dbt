{% macro format_numeric_columns(column_name, scale=2) %}
    round(cast({{ column_name }} as numeric), {{ scale }})
{% endmacro %}