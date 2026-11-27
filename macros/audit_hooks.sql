{% macro startRun() %}
    CREATE TABLE IF NOT EXISTS `dbt_mmorris_audit`.`auditLog` (runID INT64 GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1)
                                                                , modelName STRING(100)
                                                                , startEnd STRING(5)
                                                                , logTimestamp TIMESTAMP);
{% endmacro %}


{% macro logModelStart(modelName) %}

    {{ writeLog (modelName, 'Start') }}

{% endmacro %}

{% macro logModelEnd(modelName) %}
    {{ writeLog (modelName, 'End') }}

{% endmacro %}

{% macro writeLog(modelName, action) %}
    INSERT INTO `dbt_mmorris_audit`.`auditLog` (modelName, startEnd, logTimestamp)
    VALUES ( '{{modelName}}', '{{action}}', CURRENT_TIMESTAMP)
    ;
    
{% endmacro %}