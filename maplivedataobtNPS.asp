<!--#include virtual="/dbcon.asp" -->


<%
	fecha_fin = request("Tf")
	fecha_ini = request("Ti")
	station = request("u")

	Txtnps=""
	Set Conn = Server.CreateObject("ADODB.Connection")
	Conn.open constring
	Fnc_Sql = "select UNIDAD, CLIPPING,NPS_BIN AS VAL ,DATEDIFF(S,'1970-01-01',TIMEID_BIN) AS TSPLOT from NPS2012 where (TIMEID_BIN >= DATEADD(S, " & fecha_ini & ", '1970-01-01') AND TIMEID_BIN <= DATEADD(S, " & fecha_fin & ", '1970-01-01') AND UNIDAD ='" & station & "' ) ORDER BY TIMEID_BIN ASC"
	
	Set Resultado = Conn.Execute(Fnc_Sql)
	Resultado.movefirst()
	do while not Resultado.eof 
		
    nps   = Round(Resultado("VAL")*10)
	TIMEID_BIN = Resultado("TSPLOT") *1000
    CLIPPING = Resultado("CLIPPING")
	UNIDAD = Resultado("UNIDAD")
	
	Txtnps = Txtnps & nps
	Txtnps = Txtnps & "*"
	Txtnps = Txtnps & TIMEID_BIN
	Txtnps = Txtnps & "*"
	Txtnps = Txtnps & CLIPPING
	Txtnps = Txtnps & "*"
	Txtnps = Txtnps & UNIDAD
	Txtnps = Txtnps & "//"
		
	

	Resultado.movenext
	loop
	response.write Txtnps
    response.end


%>

