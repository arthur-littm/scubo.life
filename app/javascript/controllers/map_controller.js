import { Controller } from "stimulus";
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static targets = [ 'map' ];

  connect () {
    mapboxgl.accessToken = this.mapTarget.dataset.mapboxApiKey;
    this.getMap()
  }

  addMarker (coordinates) {
    const map = this.getMap()
    new mapboxgl.Marker({color: "#1eb2a6"})
      .setLngLat([ coordinates.lng, coordinates.lat ])
      .addTo(map);
    this.fitMapToMarkers(map, coordinates)
  }

  getMap () {
    const london = [-0.118092, 51.509865]
    return new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/arthur-littm/ckb19x05d00m21in3jlsd6ykh',
      center: london,
      zoom: 1
    });
  }

  fitMapToMarkers (map, coordinates) {
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([ coordinates.lng, coordinates.lat ]);
    map.fitBounds(bounds, { padding: 70, maxZoom: 12, duration: 4000 });
  };
}
