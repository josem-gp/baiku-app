import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel';

const initCarousel = () => {
  const owl = $('.owl-carousel')
  owl.owlCarousel({
    // stagePadding: 8,
    loop: false,
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
  owl.on('changed.owl.carousel', function(event) {
    const card = document.querySelectorAll('.card')[event.item.index]
    document.querySelectorAll('.animate').forEach((marker) => marker.classList.remove('animate'));
    document.getElementById(`marker-studio-${card.dataset.id}`).classList.add("animate");
  })
}

export { initCarousel };
