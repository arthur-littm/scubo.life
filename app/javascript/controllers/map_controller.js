import { Controller } from "stimulus";
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static targets = [ 'map' ];

  connect () {
    mapboxgl.accessToken = this.mapTarget.dataset.mapboxApiKey;
    console.log("hello");
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
  }

  addMarker (coordinates) {
    console.log(coordinates, "hello")
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    new mapboxgl.Marker()
      .setLngLat([ coordinates.lng, coordinates.lat ])
      .addTo(map);
    this.fitMapToMarkers(map, coordinates)
  }

  fitMapToMarkers (map, coordinates) {
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([ coordinates.lng, coordinates.lat ]);
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };
}
