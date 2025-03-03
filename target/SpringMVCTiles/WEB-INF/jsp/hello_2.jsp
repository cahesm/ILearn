<jsp:useBean id="random" class="java.util.Random" scope="application" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ page import="java.util.*" %>




      
      

<style>
    

.hero-image {
    position: relative; 
    width: 100%;
    background-repeat: no-repeat;
    background-size: cover;
    
    left: 0px;
    z-index: 0;
    
   
}
    
.carousel
{
     box-shadow: 0px 5px 5px #666;
   -webkit-box-shadow: 0px 5px 5px #666;
   -moz-box-shadow: 0px 5px 5px #666;
   position: absolute;
   top: 0;
   width: 100%;
}

.carousel-inner
{
    position: absolute;
}

.banner
{
    
   width: 100%;
}

@media only screen and (min-width: 64em)
{
    .hero-image {    
    height: 400px;    
    }
        

}

@media only screen and (max-width: 63.999em) and (min-width: 47.51em)
{
    .hero-image {
        width: 100%;
        height: 300px;    
    }    
}

@media only screen and (max-width: 47.5em)
{
    .hero-image {    
    height: 180px;    
    }
    
    
    .inputBox{ padding: 5px 5px 5px 5px !important; }
    
    .bt-search{ width: 50px !important;  }
}

@media only screen and (max-width: 63.999em)
{
form {
    margin: 0;
    padding-right: 0;
}
}

form {
    position: relative;
    width: 100%;
}

@media only screen and (min-width: 47.51em)
{
    .search-container {        
        max-width: 70rem;
        margin-bottom: 3rem;
    }
    
    .search-container input[type='search'] {
    font-size: 1.1428571429rem;
    
    
}
}


@media only screen and (max-width: 36em)
{
    .shareRent { display:block !important;;}
    .shareRentImage {
        width: auto !important;        
    }
            
}


.search-container .search-container_title {
    display: none;
}
.search-container label {
    display: none;
    text-transform: uppercase;
    font-size: .9285714286rem;
    margin-bottom: .3571428571rem;
}
.search-container>* {
    margin: 0;
}
label {
    color: #222;
}
label {
    color: #4d4d4d;
    cursor: pointer;
    display: block;
    font-size: 1rem;
    font-weight: normal;
    line-height: 1.5;
    margin-bottom: 0;
}

.search-container form {
    width: 100%;
    position: relative;
}

.search-container>* {
    margin: 0;
}

input[type='search'].ui-autocomplete-input {
    line-height: 1.9285714286rem;
}


.search-container input[type='search'] {
    padding-left: .7142857143rem;
    padding-right: .7142857143rem;
    width: 66.6666666667%;
    float: left;
    box-shadow: inset 0 0.0714285714rem 0.1428571429rem rgba(0,0,0,0.1), 0 0.0714285714rem rgba(255,255,255,0.5);
    background-color: #fff;
    background-repeat: no-repeat;
    background-position: 20px center;
    height: 4.2142857143rem;
    margin: 0;
    padding: 1.0714285714rem .7142857143rem 1.0714285714rem 4.2857142857rem !important;
    font-family: "Roboto",Helvetica,Arial,sans-serif;
    font-weight: 400;
    transition: none;
}

.search-container input[type='submit'], .search-container button {
    padding-left: .7142857143rem;
    padding-right: .7142857143rem;
    width: 33.3333333333%;
    float: left;
    font-size: 1.1428571429rem;
    height: 4.2142857143rem;
    margin-bottom: 0;
}

.searchBox{ display: flex; 
           flex-direction: row;
          width: 100%; 
          max-width: 1000px; 
          margin-left: auto; 
          margin-right: auto; 
          background: #FFFFFF;
          box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
          border-radius: 5px;           
          height: 90px;
          justify-content: center;
          align-items: center;
          padding: 0px 34px 0px 34px;
          bottom: -50px;
          gap: 9px;
}

.searchBox input{
    margin:0;
    
}


.inputBox{ display: flex; 
           flex-direction: row;
          width: 100%;
          justify-content: center;
          align-items: center;
          background: #FFFFFF;
          border: 0.5px solid rgba(51, 51, 51, 0.5);
          border-radius: 5px;
          height: 45px;
}

.inputBox input{ 
    border: 0;
}

.inputBox i{ 
    padding: 10px;
}

.inputBottom{ color: lightgray; font-size: 14px; padding: 2px;}
.inputBottom a{ 
  color: currentColor;
  text-decoration: none;
}

.showAllLink
{
    font-family: 'Montserrat';
    font-style: normal;
    font-weight: 300;
    font-size: 18px;
    line-height: 24px;
    /* identical to box height, or 133% */

    text-align: center;
    text-decoration-line: underline;

    color: #333333;
}

.bt-search{ 
width: 170px;
height: 45px;
background: #2EB66C;
box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
border-radius: 5px;
color: white;
font-family: 'Montserrat';
font-style: normal;
font-weight: 700;
font-size: 16px;
line-height: 24px;
border: 0;
}
#hd_dashboard_horzmenu
{
    max-width: 1000px;
}
    




.cardContent{
    
    font-size: 12px;        
    padding: 10px;
    text-align: justify !important;
    min-height: 130px;
}

.centered{
    justify-content: center;
}

.loginActions{
    margin-top: -10px;
}

.loginActions a{
    padding: 0px 10px 0px 10px;
}



.socialButtons .fa {
  padding: 20px;
  font-size: 30px;
  
  text-align: center;
  text-decoration: none;
  margin: 5px 2px;
  
  background: transparent;
  color: gray;
}

.socialButtons .fa:hover {
    opacity: 0.7;
}

.benefitsBlock{
        padding-right: 15px; 
        padding-left: 15px; 
    }

 
 .panel-group{ padding-bottom: 0px;}   
    
 .modal-dialog {
      max-width: 800px;
      margin: 30px auto;
  }



.modal-body {
  position:relative;
  padding:0px;
}
.close {
  position:absolute;
  right:-30px;
  top:0;
  z-index:1;
  font-size:2rem;
  font-weight: normal;
  color:#fff;
  opacity:1;
}

.player
{
    
    overflow: hidden;
    z-index: 1;
    height: 320px;
    width: 600px;
    
    filter: drop-shadow(0px 4px 15px rgba(0, 0, 0, 0.25));
    border-radius: 5px;
}

.slick-track
{
    display: flex;
    flex-direction: row;
    justify-content: center;
}
    
</style>


<script>
     $(document).ready(function(){
  

    $('.slider').slick({
  dots: false,
  infinite: false,
  speed: 300,
  slidesToShow: 3,
  slidesToScroll: 3,
  responsive: [
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 3,
        infinite: true        
      }
    },
    {
      breakpoint: 840,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 2
      }
    },
    {
      breakpoint: 480,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1
      }
    }
    // You can unslick at a given breakpoint now by adding:
    // settings: "unslick"
    // instead of a settings object
  ]
});

$( "#w-input-search" ).autocomplete({
               minLength: 1,
               source: function (request, response) {
                $.ajax({
                type: "POST",
                url:"getOffers.html",
                headers: { Accept : "application/json" },
                data: {tagName:request.term},
                success: response,                
                dataType: 'json',
                minLength: 1,
                delay: 100
                    });
                },
               
               focus: function( event, ui ) {
                  $( "#project" ).val( ui.item.label );
                     return false;
               },
               select: function( event, ui ) {
                                  
                $( "#searchTerm" ).val( ui.item.name );                 
                $( "#idHotel" ).val( 0 );                 
                $( "#idCountry" ).val( 0 );                 
                $( "#idState" ).val( 0 );                 
                $( "#idCity" ).val( 0 );
                $( "#region" ).val( "" );
                 
                  switch( ui.item.term )
                   {
                       case 'Hotel':                           
                           $( "#idHotel" ).val( ui.item.id );
                           break;
                       case 'País':                           
                           $( "#idCountry" ).val( ui.item.id );
                           break;
                       case 'Estado':                           
                           $( "#idState" ).val( ui.item.id );
                           break;
                       case 'Cidade':                           
                           $( "#idCity" ).val( ui.item.id );
                           break;
                       case 'Região':                           
                           $( "#region" ).val( ui.item.name );
                           break;
                       default:                               
                           $( "#idUnit" ).val( ui.item.id );
                           break;                           
                   }
                   
                   submitMainForm();
                  
                  return false;
               }
            })
				
            .data( "ui-autocomplete" )._renderItem = function( ul, item ) {              
               return $( "<li style='width:100%;'>" )                   
                    .append( $( "<div class='searchRow' style='width:100%;'>" )                    
                    .append( $( "<div class='searchTerm' style='display:table-cell; width:100px'>" ).text( item.term ) )
                    .append( $( "<div class='searchValue' style='display:table-cell;'>" ).text( item.name + ' - ( ' + item.occurrences + ' unidades )' ) ) )                        
                    .appendTo( ul );                       
            };

var $videoSrc;  
$('.video-btn').click(function() {
    $videoSrc = $(this).data( "src" );
});
console.log($videoSrc);

  
  
// when the modal is opened autoplay it  
$('#myModal').on('shown.bs.modal', function (e) {
    
// set the video src to autoplay and not to show related video. Youtube related video is like a box of chocolates... you never know what you're gonna get
$("#video").attr('src',$videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0" ); 
})
  


// stop playing the youtube video when I close the modal
$('#myModal').on('hide.bs.modal', function (e) {
    // a poor man's stop video
    $("#video").attr('src',$videoSrc); 
}) 

});
</script>

      
<form:form id="offersForm" method="post" action="searchOffers.html" modelAttribute="offers">
       <form:hidden  id="searchTerm" path="searchTerm" /> 
       <form:hidden  id="idHotel" path="idHotel" /> 
       <form:hidden  id="idCountry" path="idCountry" /> 
       <form:hidden  id="idState" path="idState" /> 
       <form:hidden  id="idCity" path="idCity" />
       <form:hidden  id="region" path="region" /> 
       <form:hidden  id="idUnit" path="idUnit" />        
 </form:form>
 
<div class="banner hero-image" style="background-image:url(resources/img/back.png);background-position:center; top: -90px;align-items: end; display: flex; ">
    <div class="searchBox" style='position: relative;'>           
        <div class="inputBox">
            <input id="w-input-search" type="text"  placeholder="Procure por localização ou nome de resort..." aria-label="Recipient's username" aria-describedby="basic-addon2">        
            <i class="fa fa-search"></i>            
        </div>
        <button class="bt-search" type="button" onclick="submitMainForm();">Reserve já</button>
    </div>        
</div>


        
<div class="slider">
    <c:choose>
    <c:when test="${not empty dispList}">   

    <c:set var = "single" scope = "session" value = "${ fn:length(dispList) == 1}"/>    
    <c:forEach var="dispList" items="${dispList}" varStatus="status">	
    <div class="card-item col-lg-4 col-md-6  col-sm-6 col-xs-12" ${ single ? "style='min-width:350px;'" :""}>
            <div class="card card-inverse card-primary text-center">                
                <div class="resort-image"                                 
                    <c:choose>
                    <c:when test="${empty dispList.unit.hotel.medias}">
                      style="background-image: url(resources/images/noImage.png)"
                    </c:when>    
                    <c:otherwise>
                        style = "background-image: linear-gradient(180deg, rgba(46, 182, 108, 0) 82.81%, #2EB66C 100%), linear-gradient(0deg, rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.2)), url(${pageContext.request.contextPath}/images/base/hotels/${dispList.unit.hotel.medias[0].name})"    
                    </c:otherwise>
                    </c:choose>             
                > 
                    <div class="resort-image-footer">
                        <div><i class="fa fa-calendar"></i>${dispList.nights} noites</div>
                        <div><i class="fa fa-user"></i>${dispList.unit.person} pessoas</div>
                    </div>                                        
                </div>
                <div style="display: flex; flex-direction: row; justify-content: space-between; padding:10px;">
                    <div style="display: flex; flex-direction: column; align-items: start;" >
                        <div class="resort-name">
                            ${dispList.unit.hotel.name}
                        </div>
                        <div class="resort-location">
                            ${dispList.unit.hotel.address.city}, ${dispList.unit.hotel.address.country}
                        </div>
                    </div>
                    <div>
                        <div  class="resort-price" >
                            R$ ${dispList.price}                                                
                        </div>
                    </div>
                </div>
                <div class="resort-desc">
                    ${dispList.unit.description} teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste teste
                </div>
                <div style="display: flex; flex-direction: row; justify-content: space-between; padding:10px;">
                    <div class="resort-dates">
                        <fmt:formatDate value="${dispList.startDate}" pattern="dd MMM yyyy"/> - <fmt:formatDate value="${dispList.endDate}" pattern="dd MMM yyyy"/>
                    </div>
                    <div class="resort-more">
                        <a href="showUnit.html?c=${Base64.getEncoder().encodeToString(dispList.unit.cod.getBytes())}>&back=hello.html"> Ver mais</a>
                    </div>
                </div>

            </div>
    </div>
    </c:forEach>
    </c:when>
     <c:otherwise>
          <div id="noItemsLabel" class="emptyList"> Nenhuma unidade encontrada!</div>
     </c:otherwise> 
     </c:choose>    
                                                                                                                                  
</div>        
                
                
<div class="center-box box-column"> 
    <a class = "showAllLink" href="#" onclick="submitMainForm();"> Mostrar todas unidades</a>    
</div>    

<div class="center-box box-column" style="padding-top: 28px"> 
    <div class = "title" > Facilidade e Segurança</div> 
    <div class = "description" style="width: 280px;" > Veja como é fácil e seguro reservar uma semana incrível para sua familia!</div> 
</div>    
           
<div class="center-box box-column" style="padding-top: 10px"> 
    <div class="player">
        <iframe width="100%" height="100%" frameborder="0" src="https://www.youtube.com/embed/ZM-ROLzfoYw">
        </iframe>
    </div>    
</div>   

<div class="center-box box-column" style="padding-top: 28px"> 
    <div class = "title" >Nossos Diferenciais</div> 
    <div class = "description" style="width: 500px" > Acreditamos que desbravar o mundo ao lado de quem amamos cria memórias para toda a vida, histórias para compartilhar, estreita laços e nos torna pessoas mais felizes.</div> 
</div>  

<div class="center-box box-column" style="padding-top: 28px"> 
    <div class="advantages-group"> 
        <div class="advantage-box">
            
            <div class="advantage-box-header">
                <div class="advantage-title"> Facilidade </div>
                <div> 0 </div>
            </div>
            <div class="advantage-info"> Com a TW4R você pode encontrar resorts na modalidade time sharing de forma rápida e eficiente. Além disso as operações de alugar ou cadastrar um timesharing são realizadas de forma intuitiva com poucos cliques.  </div>
            
        </div>
        <div class="advantage-box">
            <div class="advantage-box-header">
                <div class="advantage-title"> Transparência </div>
                <div> 0 </div>
            </div>
            <div class="advantage-info"> Com a TW4R você pode encontrar resorts na modalidade time sharing de forma rápida e eficiente. Além disso as operações de alugar ou cadastrar um timesharing são realizadas de forma intuitiva com poucos cliques.  </div>
        </div>
    </div>
    
    <div class="advantages-group"> 
        <div class="advantage-box">
            <div class="advantage-box-header" >
                <div class="advantage-title"> Baixo Custo </div>
                <div> 0 </div>
            </div>
            <div class="advantage-info"> Diferentemente de outras plataformas, a TW4R não cobra anuidade e não obriga o cliente a se tornar sócio para disponibilizar sua unidade de timesharing.  </div>
        </div>
        <div class="advantage-box">
            <div class="advantage-box-header">
                <div class="advantage-title"> Segurança </div>
                <div> 0 </div>
            </div>
            <div class="advantage-info"> Todas as operações realizadas pelo TW4R são seguras, desde o cadastramento das unidade de timesharing onde é exigido a comprovação da propriedade, assim como a realização das reservas, onde o usuário é informado sobre cada etapa do processo.  </div>
        </div>
    </div>
</div>  
           
       

    
<div style="display: flex; flex-direction: column; gap:10px; position: relative; top: 0; width: 100%">
  
 
    
 


    
</div>
      
    
<script>
    $('.card-footer button').click(function(e) {
                   e.preventDefault();
                   $(this).children('form').first().submit();
    });  
    
    function submitMainForm()
       {                                 
           document.getElementById("offersForm").submit();
       }
</script>





