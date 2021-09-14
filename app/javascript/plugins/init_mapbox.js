import mapboxgl from 'mapbox-gl';
import distance from '@turf/distance';
import { initRoute } from './init_route';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  const addMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 13, duration: 0 });
  };

  if (mapElement) {
    // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/teamruby/ckposdxs208tz18s7f9z585dl?optimize=true',
      zoom: 13
    });

    // This makes the route stay withing the viewport
    map.setPadding({top: 40, bottom: 150}); 

    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      const markerHtml = document.createElement('div')
      markerHtml.innerHTML = marker.marker

      new mapboxgl.Marker(markerHtml)
      .setLngLat([marker.lng, marker.lat])
      .addTo(map);
    });

    addMapToMarkers(map, markers);

    let geolocate = new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true
        },
        trackUserLocation: true,
        fitBoundsOptions: {
          maxZoom: 13
        }
      });

    map.addControl(geolocate, 'bottom-right');

    map.on('load', function() {
      document.querySelector('.mapboxgl-ctrl-geolocate').click();
    });

    if (mapElement.dataset.destination) {

      // map.on('load', function() {
      //   document.querySelector('.mapboxgl-ctrl-geolocate').click();
      // });
      // let start
      geolocate.on('geolocate', function (position) {
        console.log('geolocate')
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;
        const start = [longitude, latitude];
        setTimeout(() => {
        initRoute(start, map);

      }, 1000)
      });

    } else {


      // geolocate.on('geolocate', function (position) {
      //   const latitude = position.coords.latitude;
      //   const longitude = position.coords.longitude;
      //   const start = [longitude, latitude];
      // });
    };
  }
};

export { initMapbox };

