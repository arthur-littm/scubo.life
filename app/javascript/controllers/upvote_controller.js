import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['upvoteLink']

  toggleUpvoted(event) {
    let [data, status, xhr] = event.detail;
    this.upvoteLinkTarget.innerHTML = xhr.response;
  }
}
