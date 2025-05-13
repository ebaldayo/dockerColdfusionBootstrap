<cfif not structKeyExists(url, 'action')>
    <cfset url.action = 'edit'>
</cfif>
<cfparam name="action" default="#url.action#"/>

<cfset menuService = createObject('component', 'models.menuDayModel')>

<cfset menuDetailsService = createObject('component', 'models.menuDayDetailModel')>
<cfset menuDetailsService.action = '#action#'>

<cfset id = URL.id>
<cfset menuService.id = id>

<cfif not structKeyExists(url, 'id') or not isNumeric(URL.id)>
    <cfset message = 'Menu ID is required or invalid.'>
    <cfoutput>#message#</cfoutput>
    <cfabort>
</cfif>

<cfset qDetails = menuDetailsService.getByMenuDayId(id)>

<cfif id EQ 0>
    <cfset menuData = {}>
    <cfset menuData.menu_name = ''>
    <cfset menuData.workday = now()>
    <cfset menuData.day_status = 0>
    <cfelse>
    <cfset qGetById = menuService.getById(id)>
    <cfif qGetById.recordCount EQ 0>
        <cfset message = 'Menu not found'>
        <cfoutput>#message#</cfoutput>
        <cfabort>
    </cfif>
    <cfset menuData = {}>
    <cfset menuData.menu_name = qGetById.menu_name>
    <cfset menuData.workday = qGetById.workday>
    <cfset menuData.day_status = qGetById.day_status>
</cfif>

<cfswitch expression="#action#">
    <cfcase value="update">
        <cfset menuData.id_menu_day = id>
        <cfset menuData.menu_name = FORM.menu_name>
        <cfset menuData.workday = dateFormat(FORM.workday, 'yyyy-mm-dd')>
        <cfset qGetById = menuService.save(menuData)>
    </cfcase>
    <cfdefaultcase>
        
    </cfdefaultcase>
</cfswitch>
<html lang="en">
    <cfinclude template="../layouts/head.cfm">
    <body>
        <!-- Top Navigation Bar -->
        <cfinclude template="../layouts/top-navigation-bar.cfm">
        <div class="container-fluid">
        <cfinclude template="../layouts/sidebar.cfm">
        <!-- Main Content -->
        <div class="col-md-10 p-4">
            <h1>Menu del dia</h1>
            <p>Details</p>

            <cfoutput>
                <form action="menu_day.cfm?id=#id#&action=update" method="POST">
                    <div class="form-group pb-4">
                        <label for="menu_name">Menu name</label>
                        <input
                            type="text"
                            class="form-control" id="menu_name"
                            name="menu_name"
                            placeholder="Menu name"
                            value="#menudata.menu_name#"
                        >
                    </div>

                    <div class="form-group pb-4">
                        <label for="workday">Work day</label>
                        <input
                            type="text"
                            class="form-control" id="workday"
                            name="workday"
                            placeholder="Work day"
                            value="#menudata.workday#"
                        >
                    </div>

                    <button type="submit" class="btn btn-primary">Submit</button>
                    <div>
                        
                    </div>
                </form>
                <div class="d-flex align-items-center mb-3">
                    <h1 class="mb-0">Meals</h1>
                    <a href="menuDayDetail.cfm?id=#id#&action=new" class="btn btn-success ms-3">Add Meal</a>
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Meal</th>
                            <th scope="col">Meal Options</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="qDetails">
                            <tr>
                                <td>
                                    <strong>
                                        <a href="menuDayDetail.cfm?id=#id_menu_day#&action=edit">#meal#</a>
                                    </strong>
                                </td>
                                <td>#meal_options#</td>
                                <td>
                                    <a href="menuDayDetail.cfm?id=#id_menu_day#&action=edit" class="btn btn-primary">Edit</a>
                                    <a
                                        href="menuDayDetail.cfm?id=#id_menu_day#&action=confirmdelete"
                                        class="btn btn-danger"
                                    >Delete</a>
                                </td>
                            </tr>
                        </cfloop>
                    </tbody>
                </table>
            </cfoutput>
        </div>
        <div>
            
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>