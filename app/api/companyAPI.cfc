<cfcomponent rest="true" restPath="company" produces="application/json" displayname="CompanyAPI">

  <cfset companyService = createObject("component", "models.companyModel")>

  <!-- GET /api/company -->
  <cffunction name="getAll" access="remote" returntype="any" httpmethod="GET" restPath="">
    <cfreturn companyService.getAll()>
  </cffunction>

  <!-- GET /api/company/{id}/{day} -->
  <cffunction name="getOne" access="remote" returntype="any" httpmethod="GET" restPath="{id}/{day}">
    <cfargument name="id" type="numeric" required="true">
    <cfargument name="da" type="numeric" required="true">
    <cfreturn companyService.getById(arguments.id)>
  </cffunction>

  <!-- POST /api/company -->
  <cffunction name="create" access="remote" returntype="any" httpmethod="POST" restPath="">
    <cfset data = deserializeJSON(toString(getHttpRequestData().content))>
    <cfset companyService.create(data)>
    <cfreturn { message = "Company created." }>
  </cffunction>

  <!-- PUT /api/company/{id} -->
  <cffunction name="update" access="remote" returntype="any" httpmethod="PUT" restPath="{id}">
    <cfargument name="id" type="numeric" required="true">
    <cfset data = deserializeJSON(toString(getHttpRequestData().content))>
    <cfset data.id = arguments.id>
    <cfset companyService.update(data)>
    <cfreturn { message = "Company updated." }>
  </cffunction>

  <!-- DELETE /api/company/{id} -->
  <cffunction name="delete" access="remote" returntype="any" httpmethod="DELETE" restPath="{id}">
    <cfargument name="id" type="numeric" required="true">
    <cfset companyService.delete(arguments.id)>
    <cfreturn { message = "Company deleted." }>
  </cffunction>

</cfcomponent>
