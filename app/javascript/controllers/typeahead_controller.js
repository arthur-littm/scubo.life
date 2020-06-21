import { Controller } from "stimulus";

// limit the number of requests:
// https://medium.com/@pat_migliaccio/rate-limiting-throttling-consecutive-function-calls-with-queues-4c9de7106acc

export default class extends Controller {
  static targets = [ 'results', 'input' ];

  connect () {
    this.closeResults();
  }

  updateResults () {
    this.resultsTarget.classList.remove('d-none');
    this.resultsTarget.innerHTML = "";
    fetch(`/hashtags?query=${this.inputTarget.value.replace('#','')}`)
      .then(response => response.json())
      .then((data) => {
        this.resultsTarget.insertAdjacentHTML('afterbegin', "<small class='px-3 pt-2 text-muted'>Existing hashtags</small>")
        console.log(data)
        if (data.length === 0) {
          this.resultsTarget.insertAdjacentHTML('beforeend', "<small class='mx-3 my-2 p-2 text-muted bg-light rounded'>No match found, submit form to create new hashtag 😎</small>")
        } else {
          data.forEach((item) => {
            this.resultsTarget.insertAdjacentHTML('beforeend', this.buildHTML(item))
          });
        }
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
    data-action="mousedown->typeahead#fillInHashtag"
    data-hashtag="${ item.name }">
      <span>${ item.name }</span>
      <span class="small text-muted">${ item.count }</span>
    </div>`
  }
}
