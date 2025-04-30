<cfcomponent displayname="companyModel" output="false">
    <cfset this.tableName = "company">
    <cfset this.primaryKey = "company_id">
    <cfset this.datasource = "ds_catering_app">
    <cfset this.action = "">
    <cfset this.id = "">

    <cffunction  name="getAllCompanies" access="public" returntype="query" output="false">
        <cfquery name="rstCompanies" datasource="ds_catering_app">
            SELECT id, name, city, email, phonenumber, status
            FROM companies
        </cfquery>
        <cfreturn rstCompanies>
    </cffunction>

    <cffunction  name="getCompanyById" access="public" returntype="query" output="false">
        <cfargument name="id" type="integer" required="true">
        <cfquery name="rstCompanies" datasource="ds_catering_app">
            SELECT id, name, city, email, phonenumber, status
            FROM companies
            WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
        </cfquery>
        <cfreturn rstCompanies>
    </cffunction>

    <cffunction name="updateCompany" access="public" output="false">
        <cfargument name="data" type="struct" required="true">
        <cftry>
          <cfquery name="rstCompanies" datasource="ds_catering_app">
            UPDATE companies
            SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.name#">,
                city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.city#">,
                phonenumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.phonenumber#">,
                email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.email#">
            WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#data.id#">
          </cfquery>
          <cfcatch>
            <cfset message = "Error updating company.">
            <cfoutput>#message#</cfoutput>
            <cfabort> 
          </cfcatch>
        </cftry>
    </cffunction>
    
    <cffunction name="insertCompany" access="public" output="false">
        <cfargument name="data" type="struct" required="true">
        <cftry>
          <cfquery name="rstCompanies" datasource="ds_catering_app">
            INSERT INTO companies (name, city, email, phonenumber)
            VALUES (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.name#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.city#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.email#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.phonenumber#">
            )
          </cfquery>
          <cfcatch>
            <cfset message = "Error inserting company.">
            <cfoutput>#message#</cfoutput>
            <cfabort> 
          </cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="deleteCompanyById" access="public" returntype="query" output="false">
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
    </cffunction>
</cfcomponent>