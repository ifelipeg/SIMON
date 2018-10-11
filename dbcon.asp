<%
	Cliente = "Guadalajara"
	Unidad = "Laboratorio"
	AudioDir="/wavs/"
	versionweb=20180309
	duracionwav=5

	
	audiobasepath="e:\\public_html\guadalajara.eruido.org\"
	audiovirtualdir="/wavs/"
	

'CENTRO DEL MAPA
		'CENTRO DEL MAPA
	LatitudMapa = "20.673238"
	LongitudMapa = "-103.380585"
	
	MapZoom = 13
	
	'ESTACION ERUIDO_MX_DESARROLLO
	Latitud0 = "4.732142"
	Longitud0 =  "-74.068683"
	'ESTACION ERUIDO_MX_1
	Latitud1 = "20.672716"
	Longitud1 =  "-103.36837"
	
	'ESTACION ERUIDO_MX_2
	Latitud2 = "20.674990"
	Longitud2 =  "-103.369383"
	
'ESTACION ERUIDO_MX_3
	Latitud3 = "20.641526"
	Longitud3 =  "-103.392096"
	
	ERUIDO_MX3=2
	
	'ESTACION ERUIDO_MX_4
	Latitudi = "20.5937276"
	Longitudi =  "-105.2417736"
	
	
	Dim Zonas
	Zonas = "2,2,1,1"

	LIMITE_DIURNO = 65.
	LIMITE_NOCTURNO = 45.
	
	Inicio_diurno = TimeSerial(7, 0, 0)
	Final_diurno = TimeSerial(21, 0, 0)
	


	
	ROJO = 55.
	AMARILLO = 50.
	
	ROJO_C = 68.
	AMARILLO_C = 65.

	
    
	SERVERDBIP="172.16.140.100,1833"
	SERVERDB="ERUIDO_GUADALAJARA"
	SERVERUN="GUADALAJARA"
	SERVERPW="gdljr2k18###"
	
	SERVERAUDIOIP="172.16.140.100:1833"

	Dim constring	
	constring  = "PROVIDER=SQLOLEDB;DATA SOURCE=" & SERVERDBIP & ";DATABASE=" & SERVERDB  &  ";USER ID=" & SERVERUN  & ";PASSWORD=" & SERVERPW  & ";"
	Dim conecta
	conecta = constring

	DataloggingPathInfo="/DATALOGGING/"

	
						
%>	