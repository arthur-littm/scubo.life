import { Controller } from "stimulus";
import places from 'places.js';

export default class extends Controller {
  static targets = [ 'input' ];

  connect () {
    const placesAutocomplete = places({ container: this.inputTarget });
    const mapController = this.getController('map');
    placesAutocomplete.on('change', e => {
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
