<%
	Set Conn = Server.CreateObject("ADODB.Connection")
	Conn.open constring

	Fnc_Sql = "SELECT Unit, Active, Name, Latitud, Longitud, Zone FROM Unidades where Active=1"

	Set Resultado = Conn.Execute(Fnc_Sql)
	If Resultado.eof then
		response.write "ERUIDO ERROR: No puedo encontrar una lista de unidades"
		response.end
	Else
		Resultado.movefirst()
	
		do while not Resultado.eof 
		
			UNIDAD = Resultado("Unit")
			ACTIVE = Resultado("Active")
			NAME = Resultado("Name")
			LATITUD = Resultado("Latitud")
			LONGITUD = Resultado("Longitud")
			Zone = Resultado("Zone")
			
			UNITS = UNITS & "'" & UNIDAD & "'"
			UNITS = UNITS & ","
			
			NAMES = NAMES & "'" & NAME & "'"
			NAMES = NAMES & ","
			
			LATITUDES = LATITUDES & "'" & LATITUD & "'"
			LATITUDES = LATITUDES & ","
			
			LONGITUDES = LONGITUDES & "'" & LONGITUD & "'"
			LONGITUDES = LONGITUDES & ","
			
			Zones = Zones & "'" & Zone & "'"
			Zones = Zones & ","
			Resultado.movenext
		loop
	
	End If
	
	Fnc_Sql = "SELECT Cat FROM Categorias"

	Set Resultado = Conn.Execute(Fnc_Sql)
	If Resultado.eof then
	response.write "Damm!"
    response.end
	Else
	Resultado.movefirst()
	do while not Resultado.eof 
	
	CATEGORIAS = Resultado("Cat")

	CAT = CAT & "'" & CATEGORIAS & "'"
	CAT = CAT & ","
	
	Resultado.movenext
	loop
	
	End If
%>