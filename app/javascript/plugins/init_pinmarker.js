console.log("hi");
const initPinMarker = () => {
  document.querySelectorAll('.marker').forEach((marker) => {
    marker.addEventListener('click', (event) => {
      const id = event.currentTarget.dataset.id;
      console.log(id);
      const hiddenForm = document.querySelector('#user_parking_id');
      console.log(hiddenForm);
      hiddenForm.value = id;
      console.log(hiddenForm.value);
    })
  })
}

export { initPinMarker };


