<cfcomponent displayname="MenuDayModel">
    <cffunction name="getAll" access="public" returntype="query" output="false">
        <cfquery name="qGetAll" datasource="ds_catering_app">
        SELECT md.id_menu_day, md.workday, md.limit_hour, md.day_status, menu_name
        FROM menu_day md
        ORDER BY md.workday DESC
        </cfquery>
        <cfreturn qGetAll>
    </cffunction>

    <cffunction name="getById" access="public" returntype="query" output="false">
        <cfargument name="id" type="numeric" required="true">
        <cfquery name="qGetById" datasource="ds_catering_app">
           SELECT * FROM menu_day WHERE id_menu_day = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn qGetById>
    </cffunction>

    <cffunction name="save" access="public" returntype="void" output="false">
        <cfargument name="data" type="struct" required="true">
        <cfif structKeyExists(arguments.data, 'id_menu_day')>
            <cfquery datasource="ds_catering_app">
            UPDATE menu_day SET
            workday = <cfqueryparam value="#data.workday#" cfsqltype="cf_sql_date">,
            limit_hour = <cfqueryparam value="#data.limit_hour#" cfsqltype="cf_sql_time">,
            day_status = <cfqueryparam value="#data.day_status#" cfsqltype="cf_sql_integer">
            WHERE id_menu_day = <cfqueryparam value="#data.id_menu_day#" cfsqltype="cf_sql_integer">
            </cfquery>
        <cfelse>
            <cfquery datasource="ds_catering_app">
            INSERT INTO menu_day (workday, id_company, limit_hour, day_status)
            VALUES (
            <cfqueryparam value="#data.workday#" cfsqltype="cf_sql_date">,
            =            <cfqueryparam value="#data.limit_hour#" cfsqltype="cf_sql_time">,
            <cfqueryparam value="#data.day_status#" cfsqltype="cf_sql_integer">
            )
            </cfquery>
        </cfif>
    </cffunction>

    <cffunction name="delete" access="public" returntype="void" output="false">
        <cfargument name="id" type="numeric" required="true">
        <cfquery datasource="ds_catering_app">
        DELETE FROM menu_day WHERE id_menu_day = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        </cfquery>
    </cffunction>
</cfcomponent>
