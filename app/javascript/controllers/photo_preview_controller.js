import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'image' ];

  connect () {
    console.log('hi', this.imageTarget);
  }

  displayPreview (e) {
    const input = e.currentTarget
    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = (event) => {
        this.imageTarget.src = event.currentTarget.result;
      }
      reader.readAsDataURL(input.files[0])
      this.imageTarget.classList.remove('d-none');
    }
  }
}
