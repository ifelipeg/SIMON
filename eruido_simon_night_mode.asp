<!--#include virtual="/dbcon.asp" -->

<!--#include virtual="/funciones.asp" -->

<!--#include file="db_get_units.asp" -->

<html>
	<head>
<title>SIMON ::: Powered by eRuido</title>
	<link rel="icon" type="image/png" href="/images/ISO2.png">
	<meta name="viewport" content="user-scalable=no">


	<meta charset="utf-8">
	
	<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-80109663-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'UA-80109663-3');
</script>
	
	
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script language="javascript" type="text/javascript" src="/js/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="/js/jquery.flot.time.js"></script>
	<script language="javascript" type="text/javascript" src="/js/jquery.flot.threshold.js"></script>
	<script language="javascript" type="text/javascript" src="/js/jquery.flot.axislabels.js"></script>
		<script language="javascript" type="text/javascript" src="/js/jquery.flot.resize.js"></script>
		<script language="javascript" type="text/javascript" src="/js/jquery.flot.selection.js"></script>
		<script language="javascript" type="text/javascript" src="/js/jquery.flot.navigate.js"></script>
	
	<script language="javascript" type="text/javascript" src="/js/moment_es.js"></script>
	<script type="text/javascript" src="/js/datetimepicker/jquery.simple-dtpicker2.js"></script>
	<link type="text/css" href="/js/datetimepicker/jquery.simple-dtpicker.css" rel="stylesheet" />

	<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

	<link rel="stylesheet" href="eruido_simon_night_mode.css">

	
	</head>  
  
		


<body>

<script>

var UNITS=[<%=UNITS%>];
var NAMES=[<%=NAMES%>];
var LATITUDES=[<%=LATITUDES%>];
var LONGITUDES=[<%=LONGITUDES%>];
var Zones=[<%=Zones%>];

var Unidades=(UNITS.length);

</script>
<div id="wrapper">
	
		<div id="map">
		</div>
		
		<div id="logos">
		<table>
		<tr>
		<td>
		<a target="_blank" href="https://www.monitoreoderuido.com/">		
		<img  height="50" id="logo"  src="/images/LOGO.png"  >		
		</td>
		<td>
		<a target="_blank" href="http://cruzadacontraelruido.org/">
		<img  height="50" id="logo2" src="/images/cruzada1.png">
		</td>
		</tr>
		</table>
		</div>
		
	
		
		<div id="plot_container"  style="text-align:right;" >
		<input type="button" value="×" cursor style="cursor: pointer; border: 2px solid #000; border-radius: 10px; background-color: white; position:absolute; text-align:right; z-index:100;" class="texts_plot" onClick="closegraph()">

		<div id="plot_box" class="texts_plot"  >
		
		</div>
		
		<div align="center" id= "info1_container" >
		<p></p>
		</div>
		
		
		
		</div>
		
		<div id= "error_container" >
		<p align="center"  id="record_exist" ></p>
		</div>
		
		
				
		<div id= "loading_container" >
		<p align="center"  id="loading_zoom" ></p>
		</div>
		<div id="plot_container2" style="text-align:right;" >
		<input type="button" value="×" cursor style="cursor: pointer; border: 2px solid #000; border-radius: 10px; background-color: white; position:absolute; text-align:right; z-index:100;" class="texts_plot" onClick="closezoom()">
			
		
		<div id="plot_box2"  class="texts_plot" onclick="showPlayer_audio(event)">
		
		
		
		</div>
		
		<div id= "info2_container" >
		<p align="center"   >14:00 - 14:05</p>
		
		
		</div>

		</div>
		
		<div id="rec_player_container">
			
			<audio id="player" controls="controls"   crossOrigin = "anonymous">
				<source id="source" src="" type="audio/wav" />
				Your browser does not support the audio element.
			</audio>
			
			
		</div>
   
		<div align="center"  id="Btns" >
				
		 <select class="list" id="list" >
			<option disabled selected value>Unidades</option>
			
		</select>
		<BR>
		<p align="center" class="texts"  >Fecha del gráfico:</p>
			<input type="text" style="text-align:center;" size="30" name="date_manual" id="date_manual"  class="texts"  value="" >
				<br>
				<br>
				
						<a style="cursor: pointer;" onClick="rt()" class="texts_btn" id="actualiza" >Detener medición automatica</a>

						
		</div> 
		 	
	
   
	</div>
	
    <script>
	var panning = false;
	moment.locale('es');
	var select, o, option;
	select = document.getElementById("list");
    for ( o = 0; o < Unidades; o += 1 ) {
        option = document.createElement( 'option' );
        option.value = UNITS[o];
		option.text = NAMES[o];
        select.add( option );
		}
		
	
	
	var audioCtx = new (window.AudioContext || window.webkitAudioContext)(); 
					var source1 = audioCtx.createMediaElementSource(player);
					
					// create a gain node
					var gainNode = audioCtx.createGain();
					gainNode.gain.value = 12; // double the volume
			
					source1.connect(gainNode);
		
					// connect the gain node to an output destination
					gainNode.connect(audioCtx.destination);
	
					//source1.crossOrigin = "anonymous";			no ayuda	
										
	var Zonas=[<%=Zones%>];							
	
	var start=1;
	$("#list").val("");	
	var zoom_executed= false;
	var mov_executed= false;
	var repro_executed= false;
	var iiii=0;
		function closezoom() {
			$("#plot_container2").css("display", "none");
		}
		
		function closegraph() {
			$("#plot_container").css("display", "none");
			unidad_Id="";
		}
		var sto;
		var delay;
		delay=180;
		var  real_time;
		real_time=1;		$("#Btns").css("background-color", "#FF0000");		
		
		var now = parseInt((new Date().getTime())/1000)-delay;
	
		
		
		var now2;
		
		$(function(){ // Funcion que define acciones al abrir y cerrar el calendario
			$('*[name=date_manual]').appendDtpicker({
			"dateOnly": true,
			"firstDayOfWeek":1,
			"locale":"es",
			"dateFormat":"YYYY-MM-DD"
			});			
		});
		
		document.getElementById("date_manual").onchange = function() {
		if (start==1){		
		start=0;
		}
		else{setTimeout(obtDate,100);}
		};
		
		
		
		
		document.getElementById("list").onchange = function() {
		
		var e = document.getElementById("list");
		var name = e.options[e.selectedIndex].value;
		unidad_Id=name;
		
		
		
		
		initMap.select_unit();
		
		};
		
		
		
		
		function obtDate(){ // Funcion que obtine la fecha al cerrar el calendario
		var d = document.getElementById("date_manual").value;
		now=parseInt(((new Date(d))/1+86399000)/1000);
		real_time=0;		$("#Btns").css("background-color", "#FFF");
		
		run_st="pause";
					$("#actualiza").html("Actualizar en tiempo real");
		btnpress();
		}
		
		
	
		function hideplayer() {
		$("#rec_player_container").css("display", "none");		
		}
		
		function Zoom4Audio(TIMEID) {
		var zoom_r = 60;
		
		if (now-now2>3600) {
		zoom_r = 300;
		}
		
		$.ajax({
		url: './maplivedataobtNPS.asp',
		type: 'post',
		data: {'Tf': TIMEID, 'Ti': TIMEID-zoom_r, 'u': unidad_Id},
		success: function (response) {			
			var y = (response);
			temp2=(y);
			var parts = temp2.split("//");
			var i = 0;
			var ii = 0;
			var iii = 0;
			var minplot=1000;
			var maxplot=0;
			spl=[];
			records=[];
			while (i < parts.length-1) {				
				var parts2 = parts[i].split("*");				
				if (parts2[3]==unidad_Id){
					var inst = parseInt((parts2[0]/10));
					if (inst<minplot){
					
					minplot=inst;					
					}
					if (inst>maxplot){
					maxplot=inst;					
					}
				
					spl[iii]=[parts2[1],(parts2[0]/10)];			
					iii++;
					if (parts2[2]>=1) {
						records[ii]=[parts2[1],(parts2[0]/10)]
						ii++;
					}
				}	
			i++;
			}			
			if (iii>1){
			$("#plot_container2").css("display", "block");
			}
			plot2=$.plot("#plot_box2", [				 
			 {data: spl,
				color: '#8d007f',
			threshold: [{
				below: 45,
				color: '#00e595'
			},{
				below: 46	,
				color: '#00e66a'
			},{
				below: 48	,
				color: '#00e83e'
			},{
				below: 50	,
				color: '#00e911'
			},{
				below: 52	,
				color: '#1ceb00'
			},{
				below: 54	,
				color: '#4aec00'
			},{
				below: 55	,
				color: '#78ee00'
			},{
				below: 56	,
				color: '#a7ef00'
			},{
				below: 57	,
				color: '#d7f100'
			},{
				below: 58	,
				color: '#f2dd00'
			},{
				below: 59	,
				color: '#f4af00'
			},{
				below: 60	,
				color: '#f58000'
			},{
				below: 61	,
				color: '#f75100'
			},{
				below: 62	,
				color: '#f82200'
			},{
				below: 63	,
				color: '#f9000e'
			},{
				below: 64	,
				color: '#f00026'
			},{
				below: 66	,
				color: '#e2003c'
			},{
				below: 68	,
				color: '#d4004f'
			},{
				below: 70	,
				color: '#c6005f'
			},{
				below: 73	,
				color: '#b7006c'
			},{
				below: 76	,
				color: '#a90075'
			},{
				below: 80	,
				color: '#9b007c'
			}
			],

			 points: {show: false},
				lines: {
				show: true,
				
			
				lineWidth: 1,
				fill: true,
				
				
			  },

		 }	
			,{ data: records, 
			
			color: 'red',
		
			
			
			
			
			points: {fillColor:"red", show: true, lineWidth: 0,  radius: 8}, grid: {clickable:true, hoverable: true}}
			],
			{	 
				xaxis: {mode: "time", tickSize: [1, "minute"]},
				grid: { margin: {
				right: 10, 
				top:15, 
				left: 10
				}, clickable:true, hoverable: true, borderWidth:0, labelMargin:0, axisMargin:0, minBorderMargin:0},
				
				yaxes: [{
				
				 tickFormatter: function (v, axis) {
                        $(this).css("color", "white");
                        if (v % 10 == 0) {
                            return v + " dB   ";
                        } else {
                            return ""; }},
				
				
				 min: 57, max: 80, tickSize: 10
			}],
			
			});
			$("#loading_zoom").html("");

				

			$("#plot_box2").bind("plothover", function (event, pos, item) {
				document.body.style.cursor = "url('/images/playB.png')20 20, auto";;
				if (item) {
				if (!mov_executed){			
				
				var x = parseInt(item.datapoint[0]);
				var y = item.datapoint[1].toFixed(0);
				var timestamp = moment.utc(x).format("HH:mm:ss");
				var unidad_name=list.options[ list.selectedIndex ].text;
				$("#tooltip").html("<strong>"+ y + " dBA </strong>" + timestamp + "<br>" + unidad_name)
				.css({ top: item.pageY -80, left: item.pageX - 60 })
				.fadeIn(1);
				real_time=0;		$("#Btns").css("background-color", "#FFF");	
				
				
							$("#actualiza").html("Actualizar en tiempo real");
				mov_executed=true;
						setTimeout(function(){mov_executed=false; },100);
				
				}
				} 
				else {
				document.body.style.cursor = 'default';
				$("#tooltip").hide();
				real_time=1;		$("#Btns").css("background-color", "#FF0000");
				$("#actualiza").html("Detener actualización automatica");	
					if ( run_st=="pause"){
						real_time=0;		$("#Btns").css("background-color", "#FFF");
									$("#actualiza").html("Actualizar en tiempo real");
					}
				}

			});


			$("#plot_box2").bind("plotclick", function (event, pos, item) {
				if (item) {
				
				
				
				
				if (!repro_executed){
				
						iiii=iiii+1;
						
						repro_executed=true;
						
					var unixtimems = parseInt(item.datapoint[0]);
				
					var est = item.series.label;
					var tid = moment.utc(unixtimems).format("YYYYMMDDHHmmss");
					var urlwav=tid+".mp3";
					
					reproducirAudio_Cors(urlwav);
					
					setTimeout(function(){repro_executed=false; },500);
					}
				} 
			});
			
			
		
		
		plot2.getOptions().yaxes[0].min = minplot-3;
		
		plot2.getOptions().yaxes[0].max = maxplot+3;
		plot2.setupGrid();
		plot2.draw();	
			
		}
		
		
		
		
		
		
			});		
		}
		
		
		var thp;
		function reproducirAudio(TIMEID) {
		var uunidad_Id=unidad_Id;
		
		if (uunidad_Id=="ERUIDO_MX16"){
			uunidad_Id="ERUIDO_MX1";
		}
		
		if (uunidad_Id=="ERUIDO_MX17"){
			uunidad_Id="ERUIDO_MX1";
		}
				
		if (uunidad_Id=="ERUIDO_MX5"){
			
		var search_audio='/ERUIDO_MX5/'+TIMEID;
		}
		else
		{
		var search_audio='/wavs/'+uunidad_Id+'_AUDIO/MP3/'+TIMEID;
		}
			
			
		
		
		$.ajax({ // Revisa si el archivo de audio existe para la reproduccion			
			url:search_audio,
			type:'HEAD',
			headers: {
                    'Access-Control-Allow-Origin': '*'
                },
			error: function()
			{
				//file not exists
			},
			success: function()
				{
					clearTimeout(thp);	
					real_time=0;		$("#Btns").css("background-color", "#FFF");
					
					run_st="pause";
								$("#actualiza").html("Actualizar en tiempo real");
					$("#rec_player_container").css("display", "block");
					thp=setTimeout(hideplayer,10000);
					var player=document.getElementById('player');
					var source=document.getElementById('player');
					source.src=search_audio,
					player.load(); //just start buffering (preload)
					player.play();}
			});		
		}
		
		
		
		function reproducirAudio_Cors(TIMEID) {
					var uunidad_Id=unidad_Id;
					if (uunidad_Id=="ERUIDO_MX16"){
						uunidad_Id="ERUIDO_MX1";
					}
					if (uunidad_Id=="ERUIDO_MX17"){
						uunidad_Id="ERUIDO_MX1";
					}
							
					if (uunidad_Id=="ERUIDO_MX5"){
						
					var search_audio='http://guadalajara.eruido.org/ERUIDO_MX5/'+TIMEID;
					}
					else
					{
					var search_audio='http://guadalajara.eruido.org/wavs/'+uunidad_Id+'_AUDIO/MP3/'+TIMEID;
					}
					clearTimeout(thp);	
					real_time=0;		$("#Btns").css("background-color", "#FFF");
					
					run_st="pause";
					$("#actualiza").html("Actualizar en tiempo real");
					$("#rec_player_container").css("display", "block");
					thp=setTimeout(hideplayer,10000);
					var player=document.getElementById('player');
					var source=document.getElementById('player');
					//source.src='/audio/audio_reproductor_v2.asp?url=http://172.16.140.100:9999/wavs/'+unidad_Id+'_AUDIO/MP3/'+TIMEID+'',
					source.src=search_audio,
					
					player.load(); //just start buffering (preload)
					player.play();	
		}
		
		
		
		
		
		
		var time_lenght;
		time_lenght=86400;
		var unidad_Id;
		unidad_Id=""
		
		// Funciones que determinan el largo de tiempo de la grafica
		
		function btnpress(){
		initMap.closeinfow();
		
		$("#plot_container").css("display", "none");
		clearTimeout(sto);
		
		$("#record_exist").html("Cargando Datos...");
		
		$("#loading_zoom").html("");
		initMap.GetData();
		
		$("#plot_container2").css("display", "none");
		
		}
	

	
		var run_st="run";

		function rt() {
			
			$("#list").val("");	
			unidad_Id="";
			if (run_st == "pause"){
				run_st="run";
				$("#actualiza").html("Detener actualización automatica");	
				real_time=1;		$("#Btns").css("background-color", "#FF0000");
				now = parseInt((new Date().getTime())/1000)-delay;
						
			document.getElementById("date_manual").value=(moment.utc(now*1000).format("YYYY-MM-DD")); 
			btnpress();
			} else {
			run_st="pause";
						$("#actualiza").html("Actualizar en tiempo real");
			   real_time=0;		$("#Btns").css("background-color", "#FFF");
			   
			}
		}	

		function showPlayer_audio(event) {
			
			
			
		}
	 


var click_marker;
function initMap() {
        
	var spl;
	var records;
	spl=[];
	records=[];
	var temp2;
			
	
	function update() {			
		$("#Btns").css("display", "block");
		
		click_marker=1;
		btnpress();
    }
	
	
	
	
	
    for ( o = 0; o < Unidades; o += 1 ) {
    eval('var Lat_'+UNITS[o]+' = {lat: '+LATITUDES[o]+', lng: '+LONGITUDES[o]+'};');
	}
		
	
	
	var Lat_ERUIDO_MX_DESARROLLO = {lat: <%=Latitud0 %>, lng: <%=Longitud0 %>};
	var Lat_Al = {lat: <%=LatitudMapa %>, lng: <%=LongitudMapa %>};
		
	var mapOptions = {
																
		center: Lat_Al,
		zoom: <%=MapZoom %>,										  
		styles: [
  {
    "elementType": "labels",
    "stylers": [
      {
        "lightness": 35
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.neighborhood",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]
    };
    var map = new google.maps.Map(document.getElementById('map'),mapOptions);		
	var sensor_image = {
          url: '/images/verde.png',
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(29, 18)
    };
	
	var sensor_image_a = {
          url: '/images/verde.png',
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(29, 18)
    };
	
	var sensor_image_r = {
          url: '/images/verde.png',
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(29, 18)
    };
     		
    var ERUIDO_MX_DESARROLLO = new google.maps.Marker({
		animation: google.maps.Animation.DROP,
        position: Lat_ERUIDO_MX_DESARROLLO,
		icon: sensor_image,
		label: "dB",          
        map: map,
        title: 'ERUIDO_MX_DESARROLLO'
    });


    for ( o = 0; o < Unidades; o += 1 ) {
	
	eval('var '+UNITS[o]+' = new google.maps.Marker({position: Lat_'+UNITS[o]+', icon: sensor_image,  label: "",  map: map,title: "'+NAMES[o]+'", animation: google.maps.Animation.DROP });');
	
	}
	
	

	
	var minor_r;
	minor_r=10000;
	
	var r_ERUIDO_MX_DESARROLLO;
	r_ERUIDO_MX_DESARROLLO=minor_r;	
	var ERUIDO_MX_DESARROLLO_Circle = new google.maps.Circle({            
		strokeOpacity: 0,
		strokeWeight: 0,
		fillColor: '#00FF00',
		fillOpacity: 0.25,
		map: map,
		center: Lat_ERUIDO_MX_DESARROLLO,
		radius: r_ERUIDO_MX_DESARROLLO/(map.getZoom()*map.getZoom())
	});
	
	
	
	for ( o = 0; o < Unidades; o += 1 ) {
	
	eval('var r_'+UNITS[o]+';	r_'+UNITS[o]+'=minor_r;	var '+UNITS[o]+'_Circle = new google.maps.Circle({	clickable: false,    strokeOpacity: 0,    strokeWeight: 0,	fillColor: "#00FF00",	fillOpacity: 0.3,	map: map,	center: Lat_'+UNITS[o]+',	radius: r_'+UNITS[o]+'/(map.getZoom()*map.getZoom())    });');
	
	}
	
	
	
	
	

	
	ERUIDO_MX_DESARROLLO.addListener('click', function() {
		
		 
		 
		unidad_Id="ERUIDO_MX_DESARROLLO";		
		$("#title_unidad").html("ERUIDO_MX_DESARROLLO");		
		map.setZoom(16);
		map.setCenter(ERUIDO_MX_DESARROLLO.getPosition());
		update();	
	
		
	});
	
	function select_unit (){
		$("#title_unidad").html(unidad_Id);			
		$("#list").val(unidad_Id);		
		map.setZoom(14);
		
		eval('var lat_sel='+unidad_Id+'.getPosition().lat()');
		eval('var lng_sel='+unidad_Id+'.getPosition().lng()');
		
		map.setCenter({lat:lat_sel-0.02, lng:lng_sel});

		update();
		var unidad_name=list.options[ list.selectedIndex ].text;
		eval('info'+unidad_Id+'.setContent("<strong>"+'+unidad_Id+'_SPL+" dBA </strong>"+(moment.utc(t'+unidad_Id+'_SPL/1).format("HH:mm"))+"<br>Estación '+unidad_name+'<br>"+(moment.utc(t'+unidad_Id+'_SPL/1).format("dddd, MMMM D")));info'+unidad_Id+'.open(map,'+unidad_Id+');')
		

	}
	
	initMap.select_unit=select_unit;	
	
	
	
	for ( o = 0; o < Unidades; o += 1 ) {
		
    eval(""+UNITS[o]+".addListener('click', function() {	unidad_Id='"+UNITS[o]+"';	select_unit(unidad_Id);	});");
	eval("var info"+UNITS[o]+" = new google.maps.InfoWindow();");	
	
	}
	function closeinfow() {	
		for ( o = 0; o < Unidades; o += 1 ) {
			
		eval("info"+UNITS[o]+".close();");	
		
		}
	}										
	initMap.closeinfow=closeinfow;
	
	
	
	
	map.addListener('zoom_changed', function() {

	for ( o = 0; o < Unidades; o += 1 ) {
			
		eval(""+UNITS[o]+"_Circle.setRadius(r_"+UNITS[o]+"/(map.getZoom()*map.getZoom()));");	
		
		}
	});	
	var ERUIDO_MX_DESARROLLO_SPL;
	var tERUIDO_MX_DESARROLLO_SPL;
	
		for ( o = 0; o < Unidades; o += 1 ) {
										
			eval("var "+UNITS[o]+"_SPL;");
			eval("var t"+UNITS[o]+"_SPL;");									
		}
	
function GetData() {
		
		
		
		if (real_time==1){
		
		now = parseInt((new Date().getTime())/1000)-delay-(new Date().getTimezoneOffset())*60;
		}
		
		document.getElementById("date_manual").value=(moment.utc(now*1000).format("YYYY-MM-DD")); 

		if (now2==now-time_lenght && click_marker==0){}
		else {
		if (real_time==0){
		click_marker=0;
		}
		for ( o = 0; o < Unidades; o += 1 ) {
										
			eval("r_"+UNITS[o]+"=0;");
								
		}
		
		r_ERUIDO_MX_DESARROLLO=0;		
		
		now2 = now-time_lenght;			
		var tii=  (new Date(moment.utc(now*1000).format("YYYY-MM-DD")).getTime())/1000;
		tii= (new Date(moment.utc(tii*1000).add(6, 'h')))/1000;
		var ti24=  (new Date(moment.utc(tii*1000).add(24, 'h')))/1000;

		
		var tiii=  moment.utc(tii*1000).format("YYYY-WW");
		var tiii=  (new Date(moment.utc(tiii, 'YYYY-WW')).getTime())/1000;
		

		
		tf= moment.utc(now*1000).format("YYYY-WW");
		var tf=  (new Date(moment.utc(tf, 'YYYY-WW').add(1, 'weeks')).getTime())/1000;
		
		

	
		
		
	
		$.ajax({
		url: 'maplivedataobt.asp',
		type: 'post',
		data: {'Tf': tf, 'Ti':tiii, 'u': unidad_Id},
		success: function (response) {			
			var y = (response);
			temp2=(y);
			
			if (temp2=="Damm!")
			{
			$("#Btns").css("display", "block");
			$("#record_exist").html("No hay datos para la fecha seleccionada");
			
			
			for ( o = 0; o < Unidades; o += 1 ) {
			eval(""+UNITS[o]+"_Circle.setRadius(0);");
			eval(""+UNITS[o]+".setLabel();");									
			}	
			}
			else
			{
			

			var parts = temp2.split("//");
			var i = 0;
			var ii = 0;
			var iii = 0;
			var minplot=100;
			var maxplot=40;
			spl=[];
			records=[];
			ERUIDO_MX_DESARROLLO_SPL="";
			tERUIDO_MX_DESARROLLO_SPL="";
			
			
		for ( o = 0; o < Unidades; o += 1 ) {
			eval(''+UNITS[o]+'_SPL="";');
			eval('t'+UNITS[o]+'_SPL="";');									
		}		
	
		
			while (i < parts.length-1) {				
				var parts2 = parts[i].split("*");				
				if (parts2[3]==unidad_Id ){
					spl[iii]=[parts2[1],((parts2[0]/10))];			
					iii++;
					var inst = parseInt((parts2[0]/10));
					if (inst<minplot){
					
					minplot=inst;					
					}
					if (inst>maxplot){
					maxplot=inst;	
						
					}
					
					if (parts2[2]>=1) {
						records[ii]=[parts2[1],(parts2[0]/10)]
						ii++;
					}
				}
				
				
				
				for ( o = 0; o < Unidades; o += 1 ) {
					eval("if (parts2[3]=='"+UNITS[o]+"'){"+UNITS[o]+"_SPL=(Math.round((parts2[0]/10)).toString());t"+UNITS[o]+"_SPL=parts2[1];}");
														
				}
				
				i++;
			}
			
			
			
			
			
			
			
			
			spl.splice(-1,1);
			
					
			

			
			
				

				var i_circle=1;

				while (i_circle<=Unidades){
						
				var hora = moment.utc(now*1000).format("H");
				if (hora >= 6 && hora < 22) {
				
					if (Zonas[i_circle-1]==1){
					
					ROJO=55;					
					}
					
					if (Zonas[i_circle-1]==2){
					
					ROJO=68;
					}
					
				} else {			
									
					if (Zonas[i_circle-1]==1){
					
					ROJO=50;
					}
					
					if (Zonas[i_circle-1]==2){
					
					ROJO=65;
					}
									
				}				
		
				eval(''+UNITS[i_circle-1]+'.setLabel('+UNITS[i_circle-1]+'_SPL);');	
				
				if (eval(''+UNITS[i_circle-1]+'_SPL')>31){
						eval('r_'+''+UNITS[i_circle-1]+'=(Math.log((Math.round('+eval(''+UNITS[i_circle-1]+'_SPL')+'))/30)*2+1)*'+minor_r);
						}
						else {
						eval('r_'+''+UNITS[i_circle-1]+'='+minor_r);
						}
						eval(''+UNITS[i_circle-1]+'_Circle').setRadius(eval('r_'+''+UNITS[i_circle-1])/(map.getZoom()*map.getZoom()));				
						if (eval(''+UNITS[i_circle-1]+'_SPL')< ROJO ){
							eval(''+UNITS[i_circle-1]).setIcon(sensor_image);				
							eval(''+UNITS[i_circle-1]+'_Circle').setOptions({
							fillColor: '#00FF00',                        
							});
						}
						
						else if (ROJO  <= eval(''+UNITS[i_circle-1]+'_SPL')){	
							eval(''+UNITS[i_circle-1]).setIcon(sensor_image_r);				
							eval(''+UNITS[i_circle-1]+'_Circle').setOptions({
							fillColor: '#FF0000',                     
							});
						}
				
				
				i_circle=i_circle+1;
				}
			
				
			
						
			
			
			
			
			
			
			if (iii>1){
			
			var lasttime=spl[spl.length-1];
			lasttime=parseInt(lasttime[0]);
			
			var firsttime=spl[0];
			firsttime=parseInt(firsttime[0]);
			
			
			if (lasttime<tii*1000 || firsttime>now*1000){
				spl=[];
				iii=0;
			}
			}
			if (iii>1){
			
			var max_time;
			max_time=ti24*1000;
			if (ti24*1000>lasttime){
				max_time= lasttime;
			}
			
			var min_time;
			min_time=tii*1000;
			if (tii*1000<firsttime){
				min_time= firsttime;
			}
			
			
			var NumU = UNITS.indexOf(unidad_Id);
			
						console.log(unidad_Id);
						console.log(NumU);
				
			if (Zonas[NumU]==1){
				noche=50;
				dia=55;					
			}
					
			if (Zonas[NumU]==2){
				noche=65;
				dia=68;
			}
			
			
		var tdaybar=(tiii*1000)+(7200000);
		var u=0;
		
		var bardayar=[];
		
		while (tdaybar < tf*1000){
		bardayar[u]=[tdaybar,dia];
		tdaybar=tdaybar+(43200000*2);
			

		
		
		u=u+1;
		
		}
		
		var tnbar=(tiii*1000)-(7200000);
		 u=0;
		
		var barnar=[];
		
		while (tnbar < (tf*1000)+(7300000*3)){
		
		barnar[u]=[tnbar,noche];
		tnbar=tnbar+28800000;		
		u=u+1;
		barnar[u]=[tnbar,noche];
		u=u+1;
		barnar[u]=[tnbar,dia];
		tnbar=tnbar+28800000+28800000;
		u=u+1;		
		barnar[u]=[tnbar,dia];
		u=u+1;
		
		}
			
			
			
			
			
			
			
			
			
			$("#plot_container").css("display", "block");
			}
			
			plot1=$.plot("#plot_box", [				 
			
			
			
			
			
			
			
			
			
			
			
			
			
			{data: spl, 
			color: '#8d007f',
			threshold: [{
				below: 45,
				color: '#00e595'
			},{
				below: 46	,
				color: '#00e66a'
			},{
				below: 48	,
				color: '#00e83e'
			},{
				below: 50	,
				color: '#00e911'
			},{
				below: 52	,
				color: '#1ceb00'
			},{
				below: 54	,
				color: '#4aec00'
			},{
				below: 55	,
				color: '#78ee00'
			},{
				below: 56	,
				color: '#a7ef00'
			},{
				below: 57	,
				color: '#d7f100'
			},{
				below: 58	,
				color: '#f2dd00'
			},{
				below: 59	,
				color: '#f4af00'
			},{
				below: 60	,
				color: '#f58000'
			},{
				below: 61	,
				color: '#f75100'
			},{
				below: 62	,
				color: '#f82200'
			},{
				below: 63	,
				color: '#f9000e'
			},
			
			{
				below: 64	,
				color: '#f00026'
			},
			{
				below: 65	,
				color: '#EF0025'
			},
			{
				below: 66	,
				color: '#F10038'
			},
			{
				below: 67	,
				color: '#F3014B'
			},
			{
				below: 68	,
				color: '#F5015E'
			},
			{
				below: 69	,
				color: '#F60271'
			},
			{
				below: 70	,
				color: '#F80284'
			},
			{
				below: 71	,
				color: '#F90397'
			},
			{
				below: 72	,
				color: '#FB03AB'
			},
			{
				below: 73	,
				color: '#FD04BF'
			},
			{
				below: 74	,
				color: '#FF05D3'
			},
			{
				below: 75	,
				color: '#FD04BF'
			},
			{
				below: 76	,
				color: '#FB03AB'
			},
			{
				below: 77	,
				color: '#F90397'
			},
			{
				below: 78	,
				color: '#F80284'
			},
			{
				below: 79	,
				color: '#F60271'
			},
			{
				below: 80	,
				color: '#F5015E'
			},
			{
				below: 81	,
				color: '#f00026'
			},
			{
				below: 82	,
				color: '#F3014B'
			},
			{
				below: 83	,
				color: '#F10038'
			},
			{
				below: 84	,
				color: '#EF0025'
			},
			
			
			
			
			
			
			],
			  
			  bars: {
				show: true,
				barWidth: 300000,

				lineWidth: null,
				align: 'right',
				grid: {clickable:true, hoverable: true}
			  },
			  
			  
			  
			}	,
			
			
			
			
			
			
			{ data: records, 
			
			color: 'red',
			
			
			
			
			  			points: {fillColor:"red", show: true, lineWidth: 0,  radius: 3}, grid: {clickable:true, hoverable:true}

			
			},
			{ data: barnar, 
			
			color: "red",
			
			hoverable: false,
			clickable:false,
			
			lines: {
				show: true,	
								
				lineWidth: 1,
			  }
			}
			
			],
			{	 
			
					 zoom: {
						  interactive: true
						},
						pan: {
						  interactive: true,
						  mode: "x",
						cursor: null
						},
						
				xaxis: {mode: "time", 
				min: min_time, 
				max: max_time,
				
				zoomRange: [1800000, 1000000000], 
				panRange: [firsttime, lasttime],  
				position:top }				,
				
				 yaxes: [{
				zoomRange :false,
				panRange : false,
				 tickFormatter: function (v, axis) {
                        $(this).css("color", "white");
                        if (v % 10 == 0) {
                            return v + " dB   ";
                        } else {
                            return ""; }},
				
				
				 min: 57, max: 80, tickSize: 5
			}],		
				grid: { margin: {
				right: 10, 
				top:15, 
				left: 10
				},
			
				
				clickable:true, 
				hoverable: true, 
				borderWidth:0, labelMargin:0, axisMargin:0, minBorderMargin:0,
		
				
				},
				
			
			});
			if ( unidad_Id!=""){
			
			$("#record_exist").html("");
			
			
			
			
			
			
			//$("#info1_container").html("Registros del "+moment.utc(firsttime).format("dddd D MMMM")+" al "+ moment.utc(lasttime).format("dddd D MMMM"));
			

			}
			else{
			$("#record_exist").html("");
			}
			
			if (spl.length == 0 && unidad_Id!=""){
			
			$("#record_exist").html("No hay registros en esta fecha<br><br>Redirigiendo a " +eval('moment.utc(t'+unidad_Id+'_SPL/1).format("dddd, MMMM D, YYYY")')+"...");
			setTimeout(function(){
			now=parseInt(((new Date(eval('moment.utc(t'+unidad_Id+'_SPL/1).format("YYYY-MM-DD")')))/1+86399000)/1000);
			real_time=0;		$("#Btns").css("background-color", "#FFF");
		
			run_st="pause";
			$("#actualiza").html("Actualizar en tiempo real");
			btnpress(); }, 2000);
			
			}

				$("<div id='tooltip'></div>").css({
				position: "absolute",
				display: "none",
				"font-family": "'Roboto', sans-serif",
				padding: "2px",
				"z-index": 6,
				"background-color": "#fff",
				"font-size": 18,
				opacity: 0.9
				}).appendTo("body");
			var over1;
			$("#plot_box").bind("plothover", function (event, pos, item) {

				if (item) {
				if (!mov_executed){			
				
				var x = parseInt(item.datapoint[0]);
				var y = item.datapoint[1].toFixed(0);
				var timestamp = moment.utc(x).format("LLLL");
				var unidad_name=list.options[ list.selectedIndex ].text;
				$("#tooltip").html("<strong>"+ y + " dBA </strong>" + "<br>" +  timestamp + "<br>" + unidad_name)
				.css({ top: item.pageY - 80, left: item.pageX - 60 })
				.fadeIn(1);
				real_time=0;		$("#Btns").css("background-color", "#FFF");	
				
				
							$("#actualiza").html("Actualizar en tiempo real");
				mov_executed=true;
						setTimeout(function(){mov_executed=false; },100);
				
				}
				} 
				
				else {
				
				$("#tooltip").hide();
				real_time=1;		$("#Btns").css("background-color", "#FF0000");
				$("#actualiza").html("Detener actualización automatica");	
					if ( run_st=="pause"){
						real_time=0;		$("#Btns").css("background-color", "#FFF");
									$("#actualiza").html("Actualizar en tiempo real");
					}
				}

			});
			
				$('#plot_box canvas').bind('drag',function(){
					panning = true; 
					
					real_time=0;		$("#Btns").css("background-color", "#FFF");
		
					run_st="pause";
					$("#actualiza").html("Actualizar en tiempo real");
					
					
				}); 
				
				
							
			$('#plot_box canvas').bind('dragend',function(){
				
				setTimeout(function() {panning = false; }, 100);
				var a = parseInt(plot1.getOptions().xaxes[0].min);
				
				a=  moment.utc(a).format("YYYY-WW");
				
				a=  (new Date(moment.utc(a, 'YYYY-WW')).getTime())/1000;
				
				
				
			});
			 
			$("#plot_box").bind("plotclick", function (event, pos, item) {
			
			if (!panning){
			
			clearTimeout(sto);
			if (item) {
			
				if (!zoom_executed){
						clearTimeout(sto);
						real_time=0;		$("#Btns").css("background-color", "#FFF");
						
						run_st="pause";
									$("#actualiza").html("Actualizar en tiempo real");
						$("#loading_zoom").html("Cargando Datos...");
						
						var unixtimems = parseInt(item.datapoint[0]);
						var est = item.series.label;
						var tid = moment.utc(unixtimems).format("YYYYMMDDHHmmss");
						var urlwav=tid+".mp3";	


						$("#info2_container").html(moment.utc(unixtimems).format("dddd, D MMMM")+"       "+moment.utc(unixtimems-300000).format("HH:mm")+" "+moment.utc(unixtimems).format("HH:mm"));	


						
						Zoom4Audio(unixtimems/1000);
						zoom_executed=true;
						setTimeout(function(){zoom_executed=false; },100);
						var unidad_name=list.options[ list.selectedIndex ].text;
						eval('info'+unidad_Id).setContent("<strong>"+Math.round(item.datapoint[1])+" dBA </strong>"+(moment.utc(unixtimems/1).format("HH:mm"))+"<br>Estación "+unidad_name+"<br>"+(moment.utc(unixtimems/1).format("YYYY-MM-DD")));
						eval('info'+unidad_Id+'.open(map,'+unidad_Id+');');
						
						
						
						
						eval(unidad_Id).setLabel((Math.round(item.datapoint[1])).toString());							


						var Zonas=[<%=Zonas%>];						
						
						var NumU = UNITS.indexOf(unidad_Id);
						console.log(unidad_Id);
						console.log(NumU);
						
						var hora = moment.utc(unixtimems).format("H");
						if (hora >= 6 && hora < 22) {
						
							if (Zonas[NumU]==1){
							
							ROJO=55;					
							}
							
							if (Zonas[NumU]==2){
							
							ROJO=68;
							}
							
						} else {			
											
							if (Zonas[NumU-1]==1){
							
							ROJO=50;
							}
							
							if (Zonas[NumU-1]==2){
							
							ROJO=65;
							}
											
						}


						
						
						if (eval(unidad_Id+'_SPL')>31){
						eval('r_'+unidad_Id+'=(Math.log((Math.round('+item.datapoint[1]+'))/30)*2+1)*'+minor_r);
						}
						else {
						eval('r_'+unidad_Id+'='+minor_r);
						}
						eval(unidad_Id+'_Circle').setRadius(eval('r_'+unidad_Id)/(map.getZoom()*map.getZoom()));				
						if (item.datapoint[1]< ROJO ){
							eval(unidad_Id).setIcon(sensor_image);				
							eval(unidad_Id+'_Circle').setOptions({
							fillColor: '#00FF00',                        
							});
						}
						
						else if (ROJO  <= item.datapoint[1]){	
							eval(unidad_Id).setIcon(sensor_image_r);				
							eval(unidad_Id+'_Circle').setOptions({
							fillColor: '#FF0000',                     
							});
						}	
						
						
						
						
				}
			}
		}});
		
		
		
		
		
		
		plot1.getOptions().yaxes[0].min = minplot-3;
		
		plot1.getOptions().yaxes[0].max = maxplot+3;
		
		plot1.setupGrid();
		plot1.draw();
			
		
				
		}
				
				
		}	
		});	
		
	}
	sto=setTimeout(function(){GetData()}, 30000);
	}
	
	initMap.GetData=GetData;	
		
		
		
		
	
	GetData();		
		
	
}  
</script>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDXeNQnLYSMhthw2GA_qqtQvhrY9Aa_pBE&callback=initMap">
</script>
</body>
</html>