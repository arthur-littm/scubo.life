import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'container', 'modal' ];

  connect () {
    console.log('hello');
  }

  open (e) {
    $(this.modalTarget).modal();
  }
}
