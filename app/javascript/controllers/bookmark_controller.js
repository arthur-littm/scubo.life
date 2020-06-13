import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['bookmarkLink']

  toggleBookmarked(event) {
    let [data, status, xhr] = event.detail;
    this.bookmarkLinkTarget.innerHTML = xhr.response;
  }
}
