
<cfquery name="rstCompanies" datasource="ds_catering_app">
  SELECT id, name, city, email, phonenumber, status
  FROM companies
</cfquery>

<html lang="en">
<cfinclude template="../layouts/head.cfm" >
<body>

  <!-- Top Navigation Bar -->
  <cfinclude template="../layouts/top-navigation-bar.cfm" >

  <div class="container-fluid">
    <cfinclude template="../layouts/sidebar.cfm" >

      <!-- Main Content -->
      <div class="col-md-10 p-4">
        <h2>Companies</h2> <a href="company.cfm?id=0&action=new" class="btn btn-primary">New</a>
        <p>List of all active companies</p>

        <cfoutput>
                <table class="table">
                    <thead>
                        <tr>
                        <th scope="col">id</th>
                        <th scope="col">Name</th>
                        <th scope="col">City</th>
                        <th scope="col">Contact</th>
                        <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="rstCompanies">
                        <tr>
                            <th scope="row">#id#</th>
                            <td>
                              <strong><a href="company.cfm?id=#id#&action=edit">#name#</a></strong>
                                <cfif status EQ 1>
                                    <span class="badge bg-success">Active</span>
                                <cfelse>
                                    <span class="badge bg-danger">Inactive</span>
                                </cfif>
                            </td>
                            <td>#city#</td>
                            <td>#phonenumber# - #email#</td>
                            <td>
                                <a href="company.cfm?id=#id#&action=edit" class="btn btn-primary">Edit</a>
                                <a href="company.cfm?id=#id#&action=confirmdelete" class="btn btn-danger">Delete</a>
                            </td> 
                        </tr>
                        </cfloop>
                    </tbody>
                </table>
        </cfoutput>

      </div>
<cfinclude template="../layouts/footer.cfm" >