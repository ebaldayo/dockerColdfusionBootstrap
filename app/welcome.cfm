<cfquery name="rstCompany" datasource="ds_Bootcamp">
    SELECT * FROM company WHERE city='Medellin'
</cfquery>

<html>
    <h1>Welcome to Coldfusion Bootcamp</h1>

    <cfdump var="#rstCompany#">

    <cfoutput>
        <cftable query="rstCompany" border="1" cellpadding="5" cellspacing="0">
            <cfheader name="Content-Disposition" value="attachment; filename=company.csv">
            <cfoutput>
                <tr>
                    <th>Company ID</th>
                    <th>Company Name</th>
                    <th>City</th>
                </tr>
                <tr>
                    <td>#id#</td>
                    <td>#name#</td>
                    <td>#city#</td>
                </tr>
            </cfoutput>
        </cftable>
    </cfoutput>
</html>
