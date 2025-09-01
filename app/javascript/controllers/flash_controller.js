import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static values = {
    text: String,
    type: String,
  };

  connect() {
    const Toast = Swal.mixin({
      toast: true,
      position: "top-end",
      showConfirmButton: false,
      showCloseButton: true,
      width: '40em',
      customClass: {
        closeButton: 'rounded-md bg-gray-100 hover:bg-gray-200'
      },
      didOpen: (toast) => {
        toast.addEventListener("mouseenter", () => Swal.stopTimer);
        toast.addEventListener("mouseleave", () => Swal.resumeTimer);
      },
    });

    Toast.fire({
      icon: this.typeValue,
      title: this.textValue,
    });
  }
}