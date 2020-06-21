import { Controller } from "stimulus";
import places from 'places.js';

export default class extends Controller {
  static targets = [ 'input', 'city' ];

  connect () {
    const placesAutocomplete = places({ container: this.inputTarget });
    const mapController = this.getController('map');
    placesAutocomplete.on('change', e => {
      if (e.suggestion.county == 'London') {
        this.cityTarget.value = e.suggestion.county;
      } else if (e.suggestion.city) {
        this.cityTarget.value = e.suggestion.city;
      } else if (e.suggestion.type === 'city') {
        this.cityTarget.value = e.suggestion.name;
      } else if (e.suggestion.county) {
        this.cityTarget.value = e.suggestion.county;
      }
      const map = mapController.getMap();
      mapController.addMarker([e.suggestion.latlng], map);
    });
  }

  getController (controller_identifier) {
    return this.application.controllers.find(controller => {
      return controller.context.identifier === controller_identifier;
    });
  }
}
