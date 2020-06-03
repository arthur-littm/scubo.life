import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'counter', 'input' ];

  connect () {
    this.updateCounter();
  }

  updateCounter () {
    const chars = this.inputTarget.value.length;
    const max = this.counterTarget.dataset.max;
    const left = max - chars
    if (left > 1) {
      this.counterTarget.innerHTML = `${left} characters left.`;
    } else if (left === 1) {
      this.counterTarget.innerHTML = `${left} character left.`;
    } else if (left === 0) {
      this.counterTarget.innerHTML = "Spot on. 😎";
    } else {
      this.counterTarget.innerHTML = `${-left} too many characters. 😢`;
    }
  }
}
