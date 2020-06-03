import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'results', 'input' ];

  connect () {
  }

  updateResults () {
    this.resultsTarget.innerHTML = "";
    fetch(`/hashtags?query=${this.inputTarget.value}`)
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        data.forEach((item) => {
          this.resultsTarget.insertAdjacentHTML('afterbegin', this.buildHTML(item))
        });
      });
  }

  buildHTML(item) {
    return `<div class="d-flex justify-content-between w-100">
      <span>${ item.name }</span>
      <span>${ item.count }</span>
    </div>`
  }
}
