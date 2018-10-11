<!--#include virtual="/dbcon.asp" -->


<%
	fecha_fin = request("Tf")
	fecha_ini = request("Ti")
	station = request("u")

	Txtnps=""
	Txt=""
	Set Conn = Server.CreateObject("ADODB.Connection")
	Conn.open constring

	Fnc_Sql = "(select UNIDAD, AUDIOS,CATEGORIA,LEQ300 AS VAL ,DATEDIFF(S,'1970-01-01',TIMEID_LEQ300) AS TSPLOT from LEQ300 where (TIMEID_BIN_END >= DATEADD(S, " & fecha_ini & ", '1970-01-01') AND TIMEID_BIN_END <= DATEADD(S, " & fecha_fin & ", '1970-01-01') AND UNIDAD ='" & station & "' )) UNION ((SELECT  t.UNIDAD, 0 as AUDIOS, t.CATEGORIA, t.LEQ300 AS VAL, DATEDIFF(S,'1970-01-01',TSPLOT) AS TSPLOT FROM (SELECT UNIDAD, MAX(TIMEID_LEQ300) AS TSPLOT FROM LEQ300  GROUP BY UNIDAD) r INNER JOIN LEQ300 t ON t.UNIDAD = r.UNIDAD AND t.TIMEID_LEQ300 = r.TSPLOT))  ORDER BY UNIDAD DESC, TSPLOT ASC"


	response.write Fnc_Sql 


	Set Resultado = Conn.Execute(Fnc_Sql)
	If Resultado.eof then
	response.write "Damm!"
    response.end
	Else
	Resultado.movefirst()
	do while not Resultado.eof 
	
	Dim my_num,max,min

max=4
min=-4


my_num=int((max-min+1)*rnd+min)
			
    nps   = Round(Resultado("VAL")*10)
	
	TIMEID_BIN = Resultado("TSPLOT") *1000
    CLIPPING = Resultado("AUDIOS")
	UNIDAD = Resultado("UNIDAD")
	CAT = Resultado("CATEGORIA")
	
	Txtnps = Txtnps & nps
	Txtnps = Txtnps & "*"
	Txtnps = Txtnps & TIMEID_BIN
	Txtnps = Txtnps & "*"
	Txtnps = Txtnps & CLIPPING
	Txtnps = Txtnps & "*"
	Txtnps = Txtnps & UNIDAD
	Txtnps = Txtnps & "*"
	Txtnps = Txtnps & CAT
	Txtnps = Txtnps & "//"
		
	
	

	Resultado.movenext
	loop
	response.write Txtnps

	End If
response.end
	
	
%>

