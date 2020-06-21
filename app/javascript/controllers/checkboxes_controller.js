import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'checkbox' ];

  connect () {
  }

  updateCheckbox (e) {
    this.checkboxTargets.forEach((c) => {
      c.classList.remove('active')
      c.classList.add('inactive')
    })
    e.currentTarget.classList.toggle('active');
  }
}
