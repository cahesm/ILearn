<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.javatpoint.model.User" %>


<div id="mySidebar" class="sidebar sidemenu">
  
  <div class="topbar"> 
      <div>
        <img src="resources/img/user.png" width="20" height="20" class="rounded-circle">  
        <%=(request.getSession().getAttribute("username") != null) ? request.getSession().getAttribute("username").toString() : "Visitante"%> 
      </div>
       <i class="fa fa-close close-bt" onclick="closeNav()"></i>
      
  </div>
  
  <div class="container">
  <div class="row">
    <% if(  request.getSession().getAttribute("username")!=null ) { %>  
    <div class="col-6 text-center squareBt">        
        <div class="outsquareBt  loginBt" onclick="location.href = 'account.html'">                      
              <i class="fa fa-user"></i>              
        </div>
        <p> Conta </p>                       
    </div>
    <div class="col-6 text-center squareBt">        
        <div class="outsquareBt  loginBt" onclick="location.href = 'logout.html'">                     
              <i class="fa fa-sign-out"></i>                                      
        </div>
         <p> Sair </p>
    </div>
    <%} else { %>
    <div class="col-6 text-center squareBt">        
        <div class="outsquareBt  loginBt" onclick="location.href = 'login.html'">                      
              <i class="fa fa-sign-in"></i>                                       
        </div>
         <p> Entrar </p>
    </div>
    <div class="col-6 text-center squareBt">        
        <div class="outsquareBt  loginBt" onclick="location.href = 'register.html'">                      
              <i class="fa fa fa-user-plus"></i>                                      
        </div>
        <p> Registrar </p>
    </div>
    <%}%>  
  </div>
</div>    
  
<hr class="solid">   
  
<div class="container">
  <div class="row">
     
    
    <div class="col-6 text-center squareBt">        
        <div class="outsquareBt userBt" onclick="location.href = 'generator.html'">                      
              <i class="fa fa-search"></i>                                      
        </div>
        <p> Gerador </p>
    </div>
    
    <div class="col-6 text-center squareBt">        
        <div class="outsquareBt userBt" onclick="location.href = 'classes.html'">                      
              <i class="fa fa-calendar"></i>                                    
        </div>
         <p> Aulas </p>
    </div>
    
      <div class="col-6 text-center squareBt">        
        <div class="outsquareBt userBt" onclick="location.href = 'contact.html'">                      
              <i class="fa fa-calendar"></i>                                    
        </div>
         <p> Contato </p>
    </div>
  </div>
</div>      

      
  
  
</div>



<div class="center-box top-header">
    <div class="top-header-logo">
        <a class="navbar-logo" href="home.html">
        <img src="resources/img/ilearnLogo3.png" width="50px" alt="logo">
        <p class="brandLabel"> ILearn </p>
        </a>
    </div>
    <div class="top-header-links">
        <ul class="navbar-nav mx-auto" id="appLinks">
             
            
            <li class="nav-item">
                <a class="nav-link" href="generator.html"></i> Gerador </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="classes.html"></i> Aulas </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="contact.html"></i> Contato </a>
            </li>
             
        </ul>  
    </div>
    <div class="top-header-login">
        <ul class="navbar-nav">
        
            <% if(  request.getSession().getAttribute("username")!=null ) { %>
            <li class="nav-user-item">
                <a class="nav-link" href="account.html">Conta</a>
            </li>    
            <li class="nav-user-item filled">
                <a class="nav-link" href="logout.html">Sair</a>
            </li>
            <%} else { %>   
            <li class="nav-user-item">
                <a class="nav-link" href="login.html">Entrar</a>
            </li>
            <li class="nav-user-item filled">
                <a class="nav-link" href="register.html">Registrar</a>          
            </li>
            <%}%>    
        
            <li class="nav-item">
            <a class="nav-link" href="#" id="navbarDropdownMenuLink" style="text-align:center;" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <img src="resources/img/user.png" width="20" height="20" class="rounded-circle"> 
              <%=(request.getSession().getAttribute("username") != null) ? request.getSession().getAttribute("username").toString() : "Visitante"%>
            </a>

            </li>   
        </ul>
    </div>
    <div class="top-header-menu">
        <i class="fa fa-bars openSideMenuBtn" onclick="openNav()"></i>
    </div>    
    
</div>      
            
            <script>
      /*
      $( '.top-header-links .navbar-nav a' ).on( 'click', function () {
          alert('teste');
	$( '.top-header-links .navbar-nav' ).find( 'li.active' ).removeClass( 'active' );
	$( this ).parent( 'li' ).addClass( 'active' );
});*/
  </script>   


        