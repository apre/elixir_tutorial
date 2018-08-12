// photomapsrc hackme
var map;
var ajaxRequest;
var plotlist;
var plotlayers=[];

function initmap(mapidstr, tilesUrl) {
	// set up the map
	var map = new L.Map(mapidstr,
	{
		fullscreenControl: {
			pseudoFullscreen: false // if true, fullscreen to page width and height
		}
	});

	// create the tile layer with correct attribution
	//var osmUrl='https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
	var osmAttrib='Map data © <a href="https://openstreetmap.org">OpenStreetMap</a> contributors';
	var osm = new L.TileLayer(tilesUrl, {
		minZoom: 5, maxZoom: 18, 
		attribution: osmAttrib, 
	});		
	/*

	*/
	// start the map in Marennes 69970
	map.setView(new L.LatLng( 45.620040, 4.914717),15);
	map.addLayer(osm);

	
}


initmap("mapid",'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png')
initmap("fastmapid",'/api/v1/tiles/plop/{s}/{z}/{x}/{y}.png')
//initmap("fastmapid",'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png')
