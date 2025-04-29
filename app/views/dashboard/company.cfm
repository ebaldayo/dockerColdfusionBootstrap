<cfset action = cgi.request_method />
<cfparam name="id" default="#URL.id#">


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


          <form action="company.cfm" method="post" format="flash">
            <div class="form-group">
              <label for="companyname">Name</label>
              <input type="text" class="form-control" id="companyname" placeholder="Company name" value="#name#">
            </div>
            <div class="form-group">
              <label for="city">City</label>
              <input type="text" class="form-control" id="city" placeholder="city" value="#city#">
            </div>
            <div class="form-group">
              <label for="companyname">Phone number</label>
              <input type="text" class="form-control" id="phonenumber" placeholder="Phone number" value="#phonenumber#">
            </div>
            <div class="form-group">
              <label for="city">email</label>
              <input type="text" class="form-control" id="email" placeholder="email" value="#email#">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>

        </form>
        </cfoutput>


      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>