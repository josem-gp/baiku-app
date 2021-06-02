import Swal from 'sweetalert2'

const initSweetAlert = () => {
  Swal.fire({
    title: 'You have arrived!',
    text: 'Remember where you parked?',
    showCloseButton: true,
    showCancelButton: true,
    cancelButtonColor: '#FFE548',
    cancelButtonText: 'No, thanks!',
    confirmButtonText: 'Yes, pin location',
    confirmButtonColor: '#FAD02C',
  });
}

export { initSweetAlert }
