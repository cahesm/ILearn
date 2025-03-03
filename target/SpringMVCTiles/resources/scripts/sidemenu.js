/* Set the width of the sidebar to 250px and the left margin of the page content to 250px */
function openNav() {
  document.getElementById("mySidebar").style.width = "100%";
  //document.getElementById("main").style.marginLeft = "350px";
  
  const body = document.body;
  body.style.height = '100vh';
  body.style.overflowY = 'hidden';
  
}

/* Set the width of the sidebar to 0 and the left margin of the page content to 0 */
function closeNav() {
  document.getElementById("mySidebar").style.width = "0";
  //document.getElementById("main").style.marginLeft = "0";
  
  const body = document.body;
  const scrollY = body.style.top;
  body.style.position = '';
  body.style.top = '';
  body.style.height = '';
  body.style.overflowY = '';
  window.scrollTo(0, parseInt(scrollY || '0') * -1);
  
}

function openFilter() {
  //document.getElementById("filterBar").style.width = "350px";
  document.getElementById("filterBar").classList.add("filteropen");
  //document.getElementById("main").style.marginLeft = "350px";
  
  const body = document.body;
  body.style.height = '100vh';
  body.style.overflowY = 'hidden';
  
}

/* Set the width of the sidebar to 0 and the left margin of the page content to 0 */
function closeFilter() {
    document.getElementById("filterBar").classList.remove("filteropen");
  //document.getElementById("filterBar").style.width = "0";
  //document.getElementById("main").style.marginLeft = "0";
  
  const body = document.body;
  const scrollY = body.style.top;
  body.style.position = '';
  body.style.top = '';
  body.style.height = '';
  body.style.overflowY = '';
  window.scrollTo(0, parseInt(scrollY || '0') * -1);
  
}