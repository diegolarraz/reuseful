import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css"  // A path to the theme CSS

document.addEventListener('turbolinks:load', () => {
  // Call your JS functions here
  const datepicker = document.querySelector(".datepicker")

  if (datepicker) {
    flatpickr(".datepicker", {
      enableTime: true
    })
  }

});

