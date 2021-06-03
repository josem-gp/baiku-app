const getId = () => {
  console.log('Hi');
  document.querySelectorAll('.marker').forEach((marker) => {
    marker.addEventListener('click', (event) => {
      const id = event.currentTarget.dataset.id;
      return id;
    })
  })
}

export { getId };
