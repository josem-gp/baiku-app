import Rails from '@rails/ujs';

const triggerGeolocation = () => {
  const photoInput = document.querySelector("#parking_photos")
  const form = document.querySelector("#new_parking")
  if (photoInput) {
    photoInput.addEventListener('change', (event) => {
      Rails.fire(form, 'submit');
    })
  }
}

export { triggerGeolocation };
