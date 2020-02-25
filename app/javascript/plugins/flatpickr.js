import flatpickr from "flatpickr"
import "flatpickr/dist/themes/material_green.css" // A path to the theme CSS
import Siema from 'siema';

flatpickr(".datepicker", {
  enableTime: true
})

document.addEventListener('turbolinks:load', () => {
  // Call your JS functions here
  const mySiema = new Siema({
    duration: 250,
    loop: true,
  });
  setInterval(() => mySiema.next(), 5000)
});
