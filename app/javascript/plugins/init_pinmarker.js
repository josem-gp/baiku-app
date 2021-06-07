
const initPinMarker = () => {
  document.querySelectorAll('.marker').forEach((marker) => {
    marker.addEventListener('click', (event) => {
      const id = event.currentTarget.dataset.id;
      const hiddenForm = document.querySelector('#user_parking_id');
      hiddenForm.value = id;
    })
  })
}

export { initPinMarker };


