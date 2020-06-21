import { Controller } from "stimulus";

export default class extends Controller {
  // static targets = [ 'input', 'city' ];

  connect () {
    console.log('hi')
  }

  getItemsAroundMe() {
  navigator.geolocation.getCurrentPosition((position) => {
    console.log(position);
  });
  }
}
