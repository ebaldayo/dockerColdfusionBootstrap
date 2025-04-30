<cfif not structKeyExists(url, "action")>
  <cfset url.action = "edit">
</cfif>
<cfparam name="action" default="#url.action#"/>

<cfset companyService = createObject("component", "models.companyModel")>
<cfset companyService.action = "#action#">


<cfif not structKeyExists(url, "id") or not isnumeric(URL.id)>
  <cfset message = "Company ID is required or invalid.">
  <cfoutput>#message#</cfoutput>
  <cfabort>
</cfif>

<cfset id = URL.id>
<cfset companyService.id = id>

<cfswitch expression="#action#"> 
    <cfcase value="update">
      <cfset companyData.id = id>
      <cfset companyData.name = FORM.name>
      <cfset companyData.city = FORM.city>
      <cfset companyData.phonenumber = FORM.phonenumber>
      <cfset companyData.email = FORM.email>

      <cfset rstCompanies = companyService.updateCompany(companyData)>
    </cfcase> 

    <cfcase value="delete">
        <cfset rstCompanies = companyService.deleteCompanyById()> 
    </cfcase>
    
    <cfcase value="insert">
      <cfset newCompany.name = FORM.name>
      <cfset newCompany.city = FORM.city>
      <cfset newCompany.phonenumber = FORM.phonenumber>
      <cfset newCompany.email = FORM.email>
      <cfset companyService.insertCompany(newCompany)>
    </cfcase>
    <cfdefaultcase><!-- this include the GET -->
    </cfdefaultcase> 
</cfswitch>

<cfif id EQ 0>
  <cfset rstCompanies.id = 0>
  <cfset rstCompanies.name = "">
  <cfset rstCompanies.city = "">
  <cfset rstCompanies.phonenumber = "">
  <cfset rstCompanies.email = "">
<cfelse>
  <cfset rstCompanies = companyService.getCompanyById(id)>
</cfif>

<html lang="en">
<cfinclude template="../layouts/head.cfm" >
<body>
  <!-- Top Navigation Bar -->
  <cfinclude template="../layouts/top-navigation-bar.cfm" >

  <div class="container-fluid">
    <cfinclude template="../layouts/sidebar.cfm" >

      <!-- Main Content -->
      <div class="col-md-10 p-4">
        <cfoutput>
           <h2>#rstCompanies.name#</h2>
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
          <cfelseif action EQ "new">
                      <form action="company.cfm?id=#id#&action=insert" method="POST">
              <div class="form-group">
                <label for="companyname">Name</label>
                <input type="text" class="form-control" id="companyname" name="name" placeholder="Company name" >
              </div>
              <div class="form-group">
                <label for="city">City</label>
                <input type="text" class="form-control" id="city" name="city" placeholder="city">
              </div>
              <div class="form-group">
                <label for="companyname">Phone number</label>
                <input type="text" class="form-control" id="phonenumber" name="phonenumber" placeholder="Phone number">
              </div>
              <div class="form-group">
                <label for="city">email</label>
                <input type="text" class="form-control" id="email" name="email" placeholder="email" >
              </div>
              <button type="submit" class="btn btn-primary">Submit</button>
            </form>

          <cfelse>
            <form action="company.cfm?id=#id#&action=update" method="POST">
              <div class="form-group">
                <label for="companyname">Name</label>
                <input type="text" class="form-control" id="companyname" name="name" placeholder="Company name" value="#rstCompanies.name#">
              </div>
              <div class="form-group">
                <label for="city">City</label>
                <input type="text" class="form-control" id="city" name="city" placeholder="city" value="#rstCompanies.city#">
              </div>
              <div class="form-group">
                <label for="companyname">Phone number</label>
                <input type="text" class="form-control" id="phonenumber" name="phonenumber" placeholder="Phone number" value="#rstCompanies.phonenumber#">
              </div>
              <div class="form-group">
                <label for="city">email</label>
                <input type="text" class="form-control" id="email" name="email" placeholder="email" value="#rstCompanies.email#">
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