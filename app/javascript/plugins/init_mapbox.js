import mapboxgl from 'mapbox-gl';
import distance from '@turf/distance';
import { initRoute } from './init_route';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  const addMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 300 });
  };

  if (mapElement) {
    // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/teamruby/ckpgl9zfb166z18nz5gnbcppk',
      zoom: 12
    });

    let geolocate = new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true
        },
        trackUserLocation: true
      });

    // Add geolocate control button to the map.
    map.addControl(geolocate);

    map.on('load', function() {
      document.querySelector('.mapboxgl-ctrl-geolocate').click();
    });

    geolocate.on('geolocate', function (position) {
      const latitude = position.coords.latitude;
      const longitude = position.coords.longitude;
      const start = [longitude, latitude];
        if (mapElement.dataset.destination) {
          initRoute(start, map);
        };
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      const markerHtml = document.createElement('div')
      markerHtml.innerHTML = marker.marker

      new mapboxgl.Marker(markerHtml)
      .setLngLat([marker.lng, marker.lat])
      .addTo(map);
    });
    addMapToMarkers(map, markers);
  }
};

export { initMapbox };

