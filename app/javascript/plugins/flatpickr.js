import flatpickr from "flatpickr"

document.addEventListener('turbolinks:load', () => {
  // Call your JS functions here
  const datepicker = document.querySelector(".datepicker")

  if (datepicker) {
    flatpickr(".datepicker", {
      enableTime: true
    })
  }

});

