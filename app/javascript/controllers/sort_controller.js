import { Controller } from "stimulus";

export default class extends Controller {
  // static targets = [ 'container', 'modal' ];

  connect () {
    console.log('hello');
  }

  refresh(e) {
    const sort = e.currentTarget.options[e.currentTarget.selectedIndex].value;
    const path = `/?sort=${sort}`;
    window.location = path;
  }
}
