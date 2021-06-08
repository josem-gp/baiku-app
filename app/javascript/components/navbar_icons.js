const navbarIcons = () => {
  const icons = document.querySelectorAll(".navbar-icon")
  icons.forEach((icon) => {
    icon.addEventListener("click", (event) => {
      event.preventDefault();
      event.currentTarget.classList.add("navbar-active");
    })
  })
}

export { navbarIcons }