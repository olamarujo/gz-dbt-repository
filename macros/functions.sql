{% macro margin_percent(X, Y) %}
    ROUND(SAFE_DIVIDE(X - Y, X), 2)
{% endmacro %}

{% macro dbt_untils(A, B, C, D) %}
    SELECT *
    FROM A
    UNION ALL
    SELECT *
    FROM B
    UNION ALL
    SELECT *
    FROM C
    UNION ALL
    SELECT *
    FROM D 
{% endmacro %}