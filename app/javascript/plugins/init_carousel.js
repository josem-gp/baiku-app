import 'owl.carousel/dist/assets/owl.theme.default.css';
import 'owl.carousel';
import { syncCardMarker } from "./init_syncCardMarker";

const initCarousel = () => {
  const owl = $('.owl-carousel');
  owl.owlCarousel({
    // stagePadding: 2,
    loop: false,
    margin: 10,
    responsive:{
      0:{
        dotsEach:50,
        items:1
      },
      600:{
        dotsEach:50,
        items:2
      },
      1000: {
        dotsEach:50,
        items:3
      }
    },
    dots: false,
   })
  const mapElement = document.getElementById('map');
  if (mapElement) {
    const checkQuery = window.location.search;
    const queryElement = new URLSearchParams(checkQuery);
    const queryId = queryElement.get('to_parking');
    if (queryId) {
        // document.querySelector(`[data-id="${queryId}"]`).click()
        document.querySelectorAll('.card-index').forEach((element,idx) => {
          if (element.dataset.id == `${queryId}`) { owl.trigger('to.owl.carousel', [idx, 50])}
        })

    } else {
      syncCardMarker(owl)
      const card = document.querySelector(".active > div").dataset.id
      document.getElementById(`marker-studio-${card}`).classList.add("animate");
      owl.on('changed.owl.carousel', function(event) {
        const card = document.querySelectorAll('.card')[event.item.index]
        document.querySelectorAll('.animate').forEach((marker) => marker.classList.remove('animate'));
        const marker = document.getElementById(`marker-studio-${card.dataset.id}`);
        if (marker) {
          marker.classList.add("animate")
        }
      })
    }
  }
}

export { initCarousel };
