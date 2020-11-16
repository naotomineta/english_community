function memo() {

  const display = document.getElementById("display")
  const displayList = document.getElementById("memo-lists")

  display.addEventListener('click', function(){
    if (displayList.getAttribute("style") == "display:block;") {
      displayList.removeAttribute("style", "display:block;")
    } else {  
      displayList.setAttribute("style", "display:block;")
    }
    })
  }

  window.addEventListener('load', memo)