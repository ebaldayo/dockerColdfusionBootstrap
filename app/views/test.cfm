<cfset menuService = createObject('component', 'models.menudaymodel')>
<cfset menuDay = menuService.getMenuByDay('2025-01-01')>
<cfdump var="#serializeJSON(menuDay, "struct")#">
<hr>
<cfdump var="#serializeJSON(menuDay, "struct")#">