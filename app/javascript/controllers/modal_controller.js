import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'container', 'modal' ];

  open (e) {
    $(this.modalTarget).modal();
    const itemId = e.currentTarget.dataset.item;
    fetch(`/items/${itemId}`)
      .then(response => response.text())
      .then((data) => {
        this.containerTarget.innerHTML = data;
      });
  }
}
