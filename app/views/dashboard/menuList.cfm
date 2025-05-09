<cfset model = createObject('component', 'models.menuDayModel')>
<cfset menus = model.getAll()>

<html lang="en">
<cfinclude template="../layouts/head.cfm">
<body>

<!-- Top Navigation Bar -->
<cfinclude template="../layouts/top-navigation-bar.cfm">

<div class="container-fluid">
<cfinclude template="../layouts/sidebar.cfm">

<!-- Main Content -->
<div class="col-md-10 p-4">
    <h2>Menus</h2>
    <a href="company.cfm?id=0&action=new" class="btn btn-primary">New</a>
    <p>List of all active menus</p>

    <cfoutput>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">id</th>
                    <th scope="col">Workday</th>
                    <th scope="col">Menu</th>
                    <th scope="col">Hora limite</th>
                    <th scope="col">Status</th>
                </tr>
            </thead>
            <tbody>
                <cfloop query="menus">
                    <tr>
                        <th scope="row">#id_menu_day#</th>
                        <td>
                            <strong>
                                <a href="menu_day.cfm?id=#id_menu_day#&action=edit">#dateTimeFormat(workday, 'dd/mm/yyyy')#</a>
                            </strong>
                        </td>
                        <td>#menu_name#</td>
                        <td>#dateTimeFormat(limit_hour, 'HH:nntt')#</td>
                        <td>
                            <a href="menu_day.cfm?id=#id_menu_day#&action=edit" class="btn btn-primary">Edit</a>
                            <a href="company.cfm?id=#id_menu_day#&action=confirmdelete" class="btn btn-danger">Delete</a>
                        </td>
                    </tr>
                </cfloop>
            </tbody>
        </table>
    </cfoutput>
</div>
<cfinclude template="../layouts/footer.cfm">