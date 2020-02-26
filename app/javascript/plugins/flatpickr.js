import flatpickr from "flatpickr"
import "flatpickr/dist/themes/material_green.css" // A path to the theme CSS

const datepicker = document.querySelector(".datepicker")

if (datepicker) {
  flatpickr(".datepicker", {
    enableTime: true
  })
}


