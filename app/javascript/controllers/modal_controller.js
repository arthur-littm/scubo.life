import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'container', 'modal' ];

  open (e) {
    const itemId = e.currentTarget.dataset.item;
    fetch(`/items/${itemId}`)
      .then(response => response.text())
      .then((data) => {
        this.containerTarget.innerHTML = data;
      });
    $(this.modalTarget).modal();
  }
}
