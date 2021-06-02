import Swal from 'sweetalert2'

const initSweetAlert = (id) => {
  Swal.fire({
    title: 'You have arrived!',
    html:
    `<form action="/user/" method="patch">
      <input type="hidden" id="fname" name="fname" value="${id}"><br><br>
      <input type="submit" value="Submit">
    </form>`,
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
