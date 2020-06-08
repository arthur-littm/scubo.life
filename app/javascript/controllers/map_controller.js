import { Controller } from "stimulus";
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  static targets = [ 'map' ];

  connect () {
    mapboxgl.accessToken = this.mapTarget.dataset.mapboxApiKey;
    const map = this.getMap()
    if (this.mapTarget.dataset.markers) {
      const markers = JSON.parse(this.mapTarget.dataset.markers);
      this.addMarker(markers, map);
    }
  }

  addMarker (coordinates, map) {
    coordinates.forEach((marker) => {
      new mapboxgl.Marker({color: "#1eb2a6"})
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    })
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

  fitMapToMarkers (map, markers) {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 12, duration: 4000 });
  };
}
