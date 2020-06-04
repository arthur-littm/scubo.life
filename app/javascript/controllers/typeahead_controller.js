import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'results', 'input' ];

  connect () {
    this.closeResults();
  }

  updateResults () {
    this.resultsTarget.classList.remove('d-none');
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

  fillInHashtag(e) {
    this.inputTarget.value = e.currentTarget.dataset.hashtag;
    this.closeResults();
  }

  closeResults() {
    this.resultsTarget.classList.add('d-none');
  }

  buildHTML(item) {
    return `<div
    class="typeahead-result px-3 py-2 d-flex justify-content-between w-100 align-items-center"
    data-action="click->typeahead#fillInHashtag"
    data-hashtag="${ item.name }">
      <span>${ item.name }</span>
      <span class="small text-muted">${ item.count }</span>
    </div>`
  }
}
