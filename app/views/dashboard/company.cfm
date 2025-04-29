<cfif not structKeyExists(url, "action")>
  <cfset url.action = "edit">
</cfif>
<cfparam name="action" default="#url.action#"/>

<cfif not structKeyExists(url, "id") or not isnumeric(URL.id) or URL.id EQ 0>
  <cfset message = "Company ID is required or invalid.">
  <cfoutput>#message#</cfoutput>
  <cfabort>
</cfif>

<cfset id = URL.id>

<cfswitch expression="#action#"> 
    <cfcase value="update">
        <cftry>
          <cfquery name="rstCompanies" datasource="ds_catering_app">
            UPDATE companies
            SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">,
                city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.city#">,
                phonenumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phonenumber#">,
                email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">
            WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
          </cfquery>
          <cfcatch>
            <cfset message = "Error updating company.">
            <cfoutput>#message#</cfoutput>
            <cfabort> 
          </cfcatch>
        </cftry>
    </cfcase> 
    <cfcase value="delete">
        <cftry>
          <cfquery name="rstCompanies" datasource="ds_catering_app">
            DELETE FROM companies
            WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
          </cfquery>
          <cfcatch>
            <cfset message = "Error deleting company.">
            <cfoutput>#message#</cfoutput>
            <cfabort> 
          </cfcatch>
        </cftry>
      <cfquery datasource="ds_catering_app">
        DELETE FROM companies
        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
      </cfquery>
    </cfcase>
    <cfcase value="insert">
    </cfcase>
    <cfdefaultcase><!-- this include the GET -->
    </cfdefaultcase> 
</cfswitch>

<cfquery name="rstCompanies" datasource="ds_catering_app">
  SELECT id, name, city, email, phonenumber, status
  FROM companies
  WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
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
        <cfoutput query="rstCompanies">
           <h2>#name#</h2>
          <p>Details</p>

          <cfif action EQ "confirmdelete">
              <form action="company.cfm?id=#id#&action=delete" method="POST">
                  <div class="card mt-4">
                    <div class="card-body">
                      <h5> Are you sure you want to delete this company?</h5>
                    </div>
                  </div>
                <button type="submit" class="btn btn-primary">Delete it anyway</button>
              </form>
          <cfelse>
            <form action="company.cfm?id=#id#&action=update" method="POST">
              <div class="form-group">
                <label for="companyname">Name</label>
                <input type="text" class="form-control" id="companyname" name="name" placeholder="Company name" value="#name#">
              </div>
              <div class="form-group">
                <label for="city">City</label>
                <input type="text" class="form-control" id="city" name="city" placeholder="city" value="#city#">
              </div>
              <div class="form-group">
                <label for="companyname">Phone number</label>
                <input type="text" class="form-control" id="phonenumber" name="phonenumber" placeholder="Phone number" value="#phonenumber#">
              </div>
              <div class="form-group">
                <label for="city">email</label>
                <input type="text" class="form-control" id="email" name="email" placeholder="email" value="#email#">
              </div>
              <button type="submit" class="btn btn-primary">Submit</button>
            </form>
          </cfif>
        </cfoutput>


      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>