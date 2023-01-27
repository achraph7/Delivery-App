var map = L.map("map").setView([33.589886, -7.603869], 13);

L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
  maxZoom: 19,
  attribution:
    '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
}).addTo(map);

var marker = new L.marker({
  draggable: true,
});

map.on("click", function (e) {
  // console.log(e.latlng);

  //   if (!marker) {

  map.removeLayer(marker);

  marker = new L.marker([e.latlng.lat, e.latlng.lng], {
    draggable: true,
  })
    .bindPopup("Casablanca")
    .openPopup();
  map.addLayer(marker);
  var lat = e.latlng.lat.toString();
  var lng = e.latlng.lng.toString();
  var position = lat + ", " + lng;

  jsChannel1.postMessage(position);
  marker.on("dragend", function (e) {
    var lat = e.target._latlng.lat.toString();
    var lng = e.target._latlng.lng.toString();
    var position = lat + ", " + lng;

    jsChannel1.postMessage(position);
    // console.log(position);
  });
});
L.control.scale({ position: "bottomright" }).addTo(map);

var mapId = document.getElementById("map");
