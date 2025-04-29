
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
        <h2>Companies</h2>
        <p>List of all active companies</p>

        <cfoutput>
                <table class="table">
                    <thead>
                        <tr>
                        <th scope="col">id</th>
                        <th scope="col">Name</th>
                        <th scope="col">City</th>
                        <th scope="col">Contact</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="rstCompanies">
                        <tr>
                            <th scope="row">#id#</th>
                            <td><a href="company.cfm?id=#id#">#name#</a></td>
                            <td>#city#</td>
                            <td>#phonenumber# - #email#</td>
                        </tr>
                        </cfloop>
                    </tbody>
                </table>
        </cfoutput>

      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>