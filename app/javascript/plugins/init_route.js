import mapboxgl from 'mapbox-gl';
import distance from '@turf/distance';
import { initSweetAlert } from './init_sweetalert';
import { initGetId } from './init_getid';

const renderRoute = (start, end, map) => {
  var url = 'https://api.mapbox.com/directions/v5/mapbox/cycling/' + start[0] + ',' + start[1] + ';' + end[0] + ',' + end[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
  // make an XHR request https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
  var req = new XMLHttpRequest();
  req.open('GET', url, true);
  req.onload = function() {
    var json = JSON.parse(req.response);
    var data = json.routes[0];
    var route = data.geometry.coordinates;
    var geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: route
      }
    };
    // if the route already exists on the map, reset it using setData
    if (map.getSource('route')) {
      map.getSource('route').setData(geojson);
    } else { // otherwise, make a new request
      map.on('style.load', () => {
        const waiting = () => {
          if (!map.isStyleLoaded()) {
            setTimeout(waiting, 200);
          } else {
            map.addLayer({
              id: 'route',
              type: 'line',
              source: {
                type: 'geojson',
                data: {
                  type: 'Feature',
                  properties: {},
                  geometry: {
                    type: 'LineString',
                    coordinates: geojson
                  }
                }
              },
              layout: {
                'line-join': 'round',
                'line-cap': 'round'
              },
              paint: {
                'line-color': '#3887be',
                'line-width': 5,
                'line-opacity': 0.75
              }
            });
          }
        };
        waiting();
      })
    }
  };
  req.send();
};

const arrivalNotification = () => {
  initSweetAlert(initGetId());
}

const createRoute = (start, destination, map) => {

  const distanceToDestination = distance(start, destination);
  console.log(distanceToDestination);
  if (distanceToDestination < 0.5) {
    arrivalNotification();
  }
  else {
    console.log('You are far')
    map.on('load', function() {
      // make an initial directions request that
      // starts and ends at the same location
      renderRoute(start, start, map);
      // Add starting point to the map
      map.addLayer({
        id: 'point',
        type: 'circle',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [{
              type: 'Feature',
              properties: {},
              geometry: {
                type: 'Point',
                coordinates: start
              }
            }
            ]
          }
        },
      paint: {
        'circle-radius': 10,
        'circle-color': '#3887be'
      }
    });
      // this is where the code from the next step will go
  });
    renderRoute(start, destination, map);
  }
}

const geolocateStart = (map) => {
  var canvas = map.getCanvasContainer();
  // initialize a start corrdinate
  let start = [];

  // Add geolocate control to the map.
  let geolocate = new mapboxgl.GeolocateControl({
    positionOptions: {
      enableHighAccuracy: true
    },
    trackUserLocation: true
  });

  // Add geolocate control button to the map.
  map.addControl(geolocate);
  return geolocate
}

const initRoute = (map) => {
  // define destination point
  const mapElement = document.getElementById('map');
  const destination = JSON.parse(mapElement.dataset.destination);
  console.log(destination);

  define starting point
  initialize the map canvas to interact with later
  const geolocObject = geolocateStart(map);
  // Geolocate your position and initialize the route rendering
  geolocObject.on('geolocate', function (position) {
    const latitude = position.coords.latitude;
    const longitude = position.coords.longitude;
    const start = [longitude, latitude];
    createRoute(start, destination, map);
  });

  // simulate geoloc
  let start = [139.7081321, 35.6336481];
  renderRoute(start, start, map);

//   let counter = 0
//   const simulationCoords = [[139.7085, 35.6329933],[139.7085335,35.6328196],[139.7086486, 35.6323355],[139.7086486, 35.6323355],[139.7095947, 35.6318514], [139.7108253, 35.6315044], [139.7112196, 35.6312581], [139.711439, 35.63086635]]
//   setInterval( () => {
//     start = simulationCoords[counter];
//     renderRoute(start, destination, map);
//     const distanceToDestination = distance(start, destination);
//     console.log(distanceToDestination);
//     if (distanceToDestination < 0.005) {
//       arrivalNotification();
//       clearInterval();
//     }
//     counter += 1
//   }, 1500);
// }

export { initRoute };
