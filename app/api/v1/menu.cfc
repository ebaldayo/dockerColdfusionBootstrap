<cfcomponent rest="true" restPath="/menu" produces="application/json">
    <cfset menuService = createObject('component', 'models.menudaymodel')>
    <cfset menuDetailService = createObject('component', 'models.menudaydetailmodel')>

    <cffunction name="getMenuByDay" access="remote" returnType="any" httpMethod="GET" restPath="{day}">
        <cfargument name="day" restargsource="path" type="string" required="true">

        <cfif isDate(arguments.day)>
            <cfset arguments.day = dateFormat(parseDateTime(arguments.day), 'yyyy-mm-dd')>
        <cfelse>
            <cfthrow type="Error" message="Invalid date format in 'day' parameter.">
        </cfif>

        <cftry>
            <cfset var menuDay = menuService.getMenuByDay(arguments.day)>
            <cfif menuDay.recordCount eq 0>
                <cfthrow type="Error" message="Menu day not found" detail="No menu day found for the specified date.">
            </cfif>

            <cfset var menuDayDetails = menuDetailService.getByMenuDayId(menuDay.id_menu_day)>

            <cfcatch type="exception">
                <cfthrow type="Error" message="Database error" detail="An error occurred while retrieving the menu day.">
            </cfcatch>
        </cftry>

        <cfset var result = {
            id_menu_day: menuDay.id_menu_day,
            workday: dateFormat(menuDay.workday, 'dd-mm-yyyy'),
            limit_hour: timeFormat(menuDay.limit_hour, 'HH:mm'),
            day_status: menuDay.day_status,
            menu_name: menuDay.menu_name,
            menu_day_details: [menuDayDetails]
        }>
        <cfreturn serializeJSON(result, 'struct')>
    </cffunction>

    <cffunction name="newRequest" access="remote" returnType="any" httpMethod="POST" restPath="newRequest">
        <cfset var requestData = deserializeJSON(toString(getHTTPRequestData().content))>

        <cfreturn serializeJSON(requestData, 'struct')>
    </cffunction>
</cfcomponent>
