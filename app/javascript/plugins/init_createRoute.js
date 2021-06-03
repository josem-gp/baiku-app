import mapboxgl from 'mapbox-gl';
import distance from '@turf/distance';
import { initSweetAlert } from './init_sweetalert';

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
  req.send();
};

const arrivalNotification = () => {
  console.log('You have arrived!')
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

  // define starting point
  // initialize the map canvas to interact with later
  // const geolocObject = geolocateStart(map);
  // // Geolocate your position and initialize the route rendering
  // geolocObject.on('geolocate', function (position) {
  //   const latitude = position.coords.latitude;
  //   const longitude = position.coords.longitude;
  //   const start = [longitude, latitude];
  //   createRoute(start, destination, map);
  // });

  // simulate geoloc
  var start = [139.6925947, 35.6324644];
  renderRoute(start, start, map);
  setInterval( () => {
    start[0] = start[0] + 0.001;
    renderRoute(start, destination, map);
  }, 1000)
}

export { initRoute };
