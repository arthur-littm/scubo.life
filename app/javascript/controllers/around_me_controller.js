import { Controller } from "stimulus";

export default class extends Controller {
  // static targets = [ 'input', 'city' ];

  connect () {
  }

  getItemsAroundMe() {
    console.log('Hi 2')
    navigator.geolocation.getCurrentPosition((position) => {
      console.log(position);
      const path = `/?around_me=true&lat=${position.coords.latitude}&lng=${position.coords.longitude}`;
      window.location = path;
    });
  }
}
