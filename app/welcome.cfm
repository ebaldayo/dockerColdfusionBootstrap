<cfquery name="rstCompany"  datasource="ds_Bootcamp" >
    SELECT * FROM company WHERE city='Medellin'
</cfquery>

<html>
    <h1>Welcome to Coldfusion Bootcamp</h1>

    <cfdump var="#rstCompany#" >

    <cfoutput>
        <cfloop query="rstCompany">
            <h2>#name#</h2>
            <p>City: #city#</p>
            <p>Country: #country#</p>

            <hr/>
        </cfloop>
    </cfoutput>
</html>