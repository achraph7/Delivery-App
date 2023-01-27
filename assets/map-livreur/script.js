var map = L.map("map").setView([33.589886, -7.603869], 13);

L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
  maxZoom: 19,
  attribution:
    '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
}).addTo(map);

var marker = new L.marker({
  draggable: true,
});

function logCoord(coord, latit, longi) {
  splitted = coord.split(",");
  lng = splitted[0];
  lat = splitted[1];
  marker = new L.marker([parseFloat(lng), parseFloat(lat)], {
    draggable: false,
  })
    .bindPopup("Target")
    .openPopup();
  marker1 = new L.marker([33.589886, -7.603869], {
    draggable: false,
  })
    .bindPopup("Target")
    .openPopup();

  console.log(longi);
  var start = L.latLng(lng, lat);
  var end = L.latLng(33.589886, -7.603869);
  L.Routing.control({
    waypoints: [start, end],
    showAlternatives: true,
    altLineOptions: {
      styles: [
        {
          color: "black",
          opacity: 0.15,
          weight: 9,
        },
        {
          color: "white",
          opacity: 0.8,
          weight: 6,
        },
        {
          color: "blue",
          opacity: 0.5,
          weight: 2,
        },
      ],
    },
    geocoder: L.Control.Geocoder.nominatim(),
  }).addTo(map);
  map.addLayer(marker);
}

L.control.scale({ position: "bottomright" }).addTo(map);

var mapId = document.getElementById("map");
