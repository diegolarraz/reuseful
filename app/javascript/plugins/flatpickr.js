import flatpickr from "flatpickr"
const datepicker = document.querySelector(".datepicker")

if (datepicker) {
  flatpickr(".datepicker", {
    enableTime: true
  })
}


