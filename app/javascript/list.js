function menu() {

  const userMenu = document.getElementById("menu")
  const userMenuList = document.getElementById("user-lists")

  userMenu.addEventListener('click', function(){
    if (userMenuList.getAttribute("style") == "display:block;") {
      userMenuList.removeAttribute("style", "display:block;")
    } else {  
      userMenuList.setAttribute("style", "display:block;")
    }
    })
  }

  window.addEventListener('load', menu)