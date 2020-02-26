import flatpickr from "flatpickr"
import "flatpickr/dist/themes/material_green.css" // A path to the theme CSS
import Siema from 'siema';

const datepicker = document.querySelector(".datepicker")

if (datepicker) {
  flatpickr(".datepicker", {
    enableTime: true
  })
}


