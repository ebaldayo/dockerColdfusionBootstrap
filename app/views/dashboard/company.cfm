<cfparam  name="id" default="#URL.id#">

<cfif not isnumeric(id) or id EQ 0>
  <cfset id = 0>
  <cfset message = "Invalid company ID.">
  <cfabort>
</cfif>
<cfif not structKeyExists(url, "id")>
  <cfset message = "Company ID is required.">
  <cfabort>
</cfif>

<cfquery name="rstCompanies" datasource="ds_catering_app">
  SELECT id, name, city, email, phonenumber, status
  FROM companies
  WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
</cfquery>


<html lang="en">
<cfinclude template="../layouts/head.cfm" >
<body>
<cfdump var="#rstCompanies#" >

  <!-- Top Navigation Bar -->
  <cfinclude template="../layouts/top-navigation-bar.cfm" >

  <div class="container-fluid">
    <cfinclude template="../layouts/sidebar.cfm" >

      <!-- Main Content -->
      <div class="col-md-10 p-4">
        <cfoutput query="rstCompanies">
           <h2>#name#</h2>
          <p>Details</p>

          <div class="card mt-4">
            <div class="card-body">
              <p class="card-text">ID: #id#</p>
              <p class="card-text">City: #city#</p>
              <p class="card-text">Contact: #phonenumber# - #email#</p>
            </div>
          </div>


        <!--- ColdFusion Form --->
        <form action="company.cfm" method="post" format="flash">

          <p>
            <label for="name">Name:</label><br>
            <input type="text" name="name" id="name" required="yes" message="Please enter the company name." value="#name#">
          </p>

          <p>
            <label for="city">City:</label><br>
            <input type="text" name="city" id="city" required="yes" message="Please enter the city.">
          </p>

          <p>
            <label for="status">Status:</label><br>
            <select name="status" id="status" required="yes" message="Please select the status.">
              <option value="">-- Select --</option>
              <option value="Active">Active</option>
              <option value="Inactive">Inactive</option>
            </select>
          </p>

          <p>
            <label for="email">Email:</label><br>
            <input type="email" name="email" id="email" required="yes" message="Please enter a valid email.">
          </p>

          <p>
            <label for="phonenumber">Phone Number:</label><br>
            <input type="text" name="phonenumber" id="phonenumber" required="yes" pattern="\d{10}" message="Please enter a 10-digit phone number.">
          </p>

          <p>
            <input type="submit" name="submit" value="Register Company">
          </p>

        </form>
        </cfoutput>


      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>