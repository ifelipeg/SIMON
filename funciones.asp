<%

'--------Vitglobal.com                    --
'---------eRuido funciones web version 2015  --

	
Function DisplayFecha(fh)
		DisplayFecha = DatePart("yyyy",fh)&"-"&DatePart("m",fh)&"-"&DatePart("d",fh)
End Function

Function DisplayHora(fh)

		h = DatePart("h",fh)
		if len(h)<2 then 
			h = "0" & h
		end if

		m = DatePart("n",fh)
		if len(m)<2 then 
			m = "0" & m
		End if

		s = DatePart("s",fh)
		if len(s)<2 then 
			s = "0" & s
		End if

		DisplayHora = h&":"&m&":"&s

		'DisplayHora = DatePart("h",fh)&"-"&DatePart("n",fh)&"-"&DatePart("s",fh)


End Function



Function FormatHora_hhmmss(strDateStamp)
		 strDateStamp = right((strDateStamp),6)
		 FormatHora_hhmmss = Mid(strDateStamp,1,2) & ":" & Mid(strDateStamp,3,2) & ":" & Mid(strDateStamp,5,2)
End Function




Function DisplayDatestampHours(strDateStamp)
	DisplayDatestampHours = Mid(strDateStamp,7,2) & "/" & Mid(strDateStamp,5,2) & "/" & Mid(strDateStamp,1,4) & " " & Mid(strDateStamp,9,2)& ":" & Mid(strDateStamp,11,2)
End Function

Function DisplayDatestamp(strDateStamp)
	DisplayDatestamp = Mid(strDateStamp,7,2) & "/" & Mid(strDateStamp,5,2) & "/" & Mid(strDateStamp,1,4)
End Function

Function DisplayDatestampYYYYMMDD(strDateStamp)
	DisplayDatestampYYYYMMDD =  Mid(strDateStamp,1,4) & "/" & Mid(strDateStamp,5,2) & "/" & Mid(strDateStamp,7,2)
End Function


Function TimeIdYYYY(strTimeId)
	TimeIdYYYY =  Mid(strTimeId,1,4)
End Function

Function TimeIdMM(strTimeId)
	TimeIdMM = Mid(strTimeId,5,2)
End Function

Function TimeIdDD(strTimeId)
	TimeIdDD = Mid(strTimeId,7,2)
End Function

Function TimeIdhour(strTimeId)
	TimeIdhour =  Mid(strTimeId,9,2)
End Function

Function TimeIdminute(strTimeId)
	TimeIdminute = Mid(strTimeId,11,2)
End Function

Function TimeIdsecond(strTimeId)
	TimeIdsecond = Mid(strTimeId,13,2)
End Function

Function MyFormatNumber(number,decimals)
	
	if(IsNumeric(number) and IsNumeric(decimals) ) Then

		MyFormatNumber = FormatNumber(number,decimals)
	else
		MyFormatNumber = -1
	end if

	

End Function



Function  StrToSqlDateTime(strTimeId)

'StrToSqlDateTime="2016-07-08T20:07:15.000"

StrToSqlDateTime=TimeIdYYYY(strTimeId)+"-"+TimeIdMM(strTimeId)+"-"+TimeIdDD(strTimeId)+"T"+TimeIdhour(strTimeId)+":"+TimeIdminute(strTimeId)+":"+TimeIdsecond(strTimeId)

End Function



	
Function TimeidBin2TimeIdTxt(fh)



y=DatePart("yyyy",fh)

if len(y)=2 then 
	y = "20" & y
end if

mes= DatePart("m",fh)
if len(mes)<2 then 
	mes = "0" & mes
end if

d=DatePart("d",fh)
if len(d)<2 then 
	d = "0" & d
end if

h = DatePart("h",fh)
if len(h)<2 then 
	h = "0" & h
end if

m = DatePart("n",fh)
if len(m)<2 then 
	m = "0" & m
End if

s = DatePart("s",fh)
if len(s)<2 then 
	s = "0" & s
End if

		TimeidBin2TimeIdTxt = y&mes&d&h&m&s

End Function




%>