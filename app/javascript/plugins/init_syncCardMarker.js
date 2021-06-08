import 'owl.carousel';

const syncCardMarker = (owl) => {
  document.querySelectorAll('.marker').forEach((marker, idx) => {
    marker.addEventListener('click', (event) => {
      const markerId = event.currentTarget.dataset.id;
      owl.trigger('to.owl.carousel', [idx, 300])
    })
  })
}

export { syncCardMarker };
