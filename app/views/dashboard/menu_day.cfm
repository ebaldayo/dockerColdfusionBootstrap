<cfif not structKeyExists(url, 'action')>
    <cfset url.action = 'edit'>
</cfif>
<cfparam name="action" default="#url.action#"/>

<cfset menuService = createObject('component', 'models.menuDayModel')>
<cfset menuService.action = '#action#'>

<cfset id = URL.id>
<cfset menuService.id = id>

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
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>