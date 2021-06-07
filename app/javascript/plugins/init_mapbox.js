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
      center: [139.6925947, 35.6324644], // starting position
      zoom: 12
    });

    const geolocate = map.addControl(new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
        trackUserLocation: true
    }));
    // Add the control to the map.
    map.addControl(geolocate);
    map.on('load', function() {
      document.querySelector('.mapboxgl-ctrl-geolocate').click();
    });

  if (mapElement.dataset.destination) {
    initRoute(map);
  }

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

