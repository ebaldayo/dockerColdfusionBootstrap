<cfif not structKeyExists(url, 'action')>
    <cfset url.action = 'edit'>
</cfif>
<cfparam name="action" default="#url.action#"/>

<cfset menuService = createObject('component', 'models.menuDayModel')>
<cfset menuService.action = '#action#'>

<cfset menuDetailsService = createObject('component', 'models.menuDayDetailModel')>
<cfset menuDetailsService.action = '#action#'>

<cfset id = URL.id>
<cfset menuService.id = id>

<cfset qDetails = menuDetailsService.getByMenuDayId(id)>

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
                                <strong><a href="menuDayDetail.cfm?id=#id#&action=edit">#meal#</a></strong>
                                </td>
                                <td>#meal_options#</td>
                                <td>
                                    <a href="menuDayDetail.cfm?id=#id_menu_day#&action=edit" class="btn btn-primary">Edit</a>
                                    <a href="menuDayDetail.cfm?id=#id_menu_day#&action=confirmdelete" class="btn btn-danger">Delete</a>
                                </td> 
                            </tr>
                            </cfloop>
                        </tbody>
                    </table>
                </cfoutput>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>