<cfcomponent persistent="true" entityname="Company" table="Company" datasource="ds_catering_app">
    <cfproperty name="id" column="ARTISTID" generator="increment">
    <cfproperty name="firstname">
    <cfproperty name="lastname">
    <cfproperty name="address">
    <cfproperty name="city">
    <cfproperty name="state">
    <cfproperty name="postalcode">
    <cfproperty name="email">
    <cfproperty name="phone">
    <cfproperty name="fax">
    <cfproperty name="thepassword">
</cfcomponent>