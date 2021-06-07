// import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel';
import { syncCardMarker } from "./init_syncCardMarker";

const initCarousel = () => {
  const owl = $('.owl-carousel');
  owl.owlCarousel({
    // stagePadding: 2,
    loop: true,
    margin: 10,
    responsive:{
      0:{
        items:1
       },
      600:{
       items:3
       },
      1000: {
          items: 5
      }
     },
   })
    const card = document.querySelector(".owl-item > .card")
    document.getElementById(`marker-studio-${card.dataset.id}`).classList.add("animate");
  owl.on('changed.owl.carousel', function(event) {
    const card = document.querySelectorAll('.card')[event.item.index]
    document.querySelectorAll('.animate').forEach((marker) => marker.classList.remove('animate'));
    const marker = document.getElementById(`marker-studio-${card.dataset.id}`);
    if (marker) {
      marker.classList.add("animate")
    }
  })
  syncCardMarker(owl)
}

export { initCarousel };
