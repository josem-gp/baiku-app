import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel';

const initCarousel = () => {
  $('.owl-carousel').owlCarousel({
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
}

export { initCarousel };