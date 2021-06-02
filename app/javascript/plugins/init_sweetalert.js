import Swal from 'sweetalert2'

const initSweetAlert = (id) => {
  Swal.fire({
    title: 'You have arrived!',
    text: 'Remember where you parked?',
    showCloseButton: true,
    showCancelButton: true,
    cancelButtonColor: '#FFE548',
    cancelButtonText: 'No, thanks!',
    confirmButtonText: 'Yes, pin location',
    confirmButtonColor: '#FAD02C',
  }).then((result) => {
  if (result.isConfirmed) {
    document.querySelector('.simple_form').submit();
  } else if (result.isDenied) {
    Swal.fire('Changes are not saved', '', 'info')
  }
});
}

export { initSweetAlert }
