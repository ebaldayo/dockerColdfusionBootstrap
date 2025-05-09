<cfcomponent displayName="MenuDayModel">

    <cffunction name="getByMenuDayId" access="public" returntype="query" output="false">
        <cfargument name="menuDayId" type="numeric" required="true">
        <cfquery name="qGetByMenuDay" datasource="ds_catering_app">
            SELECT id_menu_day_detail, id_menu_day, meal, meal_options
            FROM menu_day_detail
            WHERE id_menu_day = <cfqueryparam value="#arguments.menuDayId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfreturn qGetByMenuDay>
    </cffunction>

</cfcomponent>