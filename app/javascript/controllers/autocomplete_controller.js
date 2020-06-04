import { Controller } from "stimulus";
import places from 'places.js';

export default class extends Controller {
  static targets = [ 'input' ];

  connect () {
    const placesAutocomplete = places({ container: this.inputTarget });
    placesAutocomplete.on('change', e => {
      this.getController('map').addMarker(e.suggestion.latlng);
    });
  }

  getController (controller_identifier) {
    return this.application.controllers.find(controller => {
      return controller.context.identifier === controller_identifier;
    });
  }
}
