<!--- Please insert your code here --->
<cfoutput >
<cfxml variable="theResult">
<cfset datasrc="cfartgallery">
<datasource name="#datasrc#">
<cfdbinfo  
    type="dbnames" 
    datasource="#datasrc#" 
    name="dbdata">
<cfdbinfo datasource="#datasrc#" type="tables" name="getTables">
<cfloop query="getTables">
	<cfif left(getTables.TABLE_NAME, 3) NEQ 'SYS'>
		<table name="#getTables.TABLE_NAME#">
			<cfdbinfo datasource="#datasrc#" name="getColumns" type="columns" table="#getTables.TABLE_NAME#" />
			<cfloop query="getColumns">
			<field name="#getColumns.COLUMN_NAME#" datatype="#getColumns.TYPE_NAME#" value="#getColumns.COLUMN_DEFAULT_VALUE#"></field>
			</cfloop>
		<cfquery datasource="#datasrc#" name="rowEntries">
			SELECT * from #getTables.TABLE_NAME#
		</cfquery>
		<data>
			<cfloop query="rowEntries">
				<row>
				<cfloop list="#ArrayToList(rowEntries.getColumnNames())#" index="col">
					<field>#rowEntries[col][currentrow]#</field>
				</cfloop>
				</row>
			</cfloop>
		</data>
		</table>
     </cfif>  	
</cfloop>
</datasource>
</cfxml>	
</cfoutput>
<cfdump var="#theResult#" >

<cffile action="write" file="C:\Users\vadiraja\Documents\xmldoc.xml" output="#theResult#">