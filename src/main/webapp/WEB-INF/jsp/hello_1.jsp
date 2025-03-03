<jsp:useBean id="random" class="java.util.Random" scope="application" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ page import="java.util.*" %>


<html>
   <head>      
      <title>Busca</title>
      <script src="<c:url value="/resources/scripts/jquery-ui.js" />"></script>
      <script src="<c:url value="/resources/scripts/slick.min.js" />"></script>
      <link href="<c:url value="/resources/styles/jquery-ui.css" />" rel="stylesheet">
      <link href="<c:url value="/resources/styles/searchCards.css" />" rel="stylesheet">
      <link href="<c:url value="/resources/styles/slick.css" />" rel="stylesheet">
      <link href="<c:url value="/resources/styles/slick-theme.css" />" rel="stylesheet">

<style>
    

.hero-image {
    position: relative; 
    width: 100%;
    background-repeat: no-repeat;
    background-size: cover;
    
    left: 0px;
    z-index: -1;
    
   
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
    box-shadow: 0px 5px 5px #666;
   -webkit-box-shadow: 0px 5px 5px #666;
   -moz-box-shadow: 0px 5px 5px #666;   
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
button, .button {
    box-shadow: 0 0.0714285714rem 0.2142857143rem 0 rgba(0,0,0,0.12);
    text-transform: uppercase;
    transition-duration: 150ms;
}
.inputBox{ max-width: 1000px; margin: 0px auto; margin-top: -40px; background-color: rgba(52,58,64, 0.7); padding: 25px 50px 10px 50px; }
.inputBottom{ color: lightgray; font-size: 14px; padding: 2px;}
.inputBottom a{ 
  color: currentColor;
  text-decoration: none;
}
.form-control{ margin: 0px !important; border-radius: 0.25rem !important;; border-color: #6c757d !important; height: 60px !important; border-top-right-radius: 0 !important; border-bottom-right-radius: 0 !important; }
.bt-search{ background-color: cadetblue; width: 80px; border-radius: 5px; }
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
  z-index:999;
  font-size:2rem;
  font-weight: normal;
  color:#fff;
  opacity:1;
}
    
</style>


</style>

</head>  

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
<body>
       
 
<div style="display: flex; flex-direction: column; gap:10px; position: absolute; top: 0;">
  
 
    
<div class="banner hero-image" style="background-image:url(resources/img/back.png);background-position:center">
        
</div>    


    
<div class="hd_center_container">
    <div class="center"  style="margin-bottom: 5px !important;">    
        
        <div class = "panel-group">
            <div class = "panel panel-default">
                
                <div id = "unitList" class = "panel-collapse expand">
                    <div class = "panel-body">  
                        <div class="container">
                            
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
                                             style="background-image: url(${pageContext.request.contextPath}/images/base/hotels/${dispList.unit.hotel.medias[0].name})"
                                          </c:otherwise>
                                        </c:choose>             
                                        > 
                                        <div class="mediaTag">Novidade</div>
                                        </div>
                                            <div class="card-block">
                                                <div class="card-header">${dispList.unit.hotel.name} </div>
                                                <div class="card-location">${dispList.unit.hotel.address.city}, ${dispList.unit.hotel.address.country}</div>
                                                <h5 class="price-value">R$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${dispList.finalPrice}" /> </h5>                                                
                                                <div class="card-days">${dispList.nights} noites (R$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${dispList.price/dispList.nights}" />/noite)</div>    

                                                <div class="card-dates text-center">    
                                                    <i class="fa fa-calendar"></i><fmt:formatDate value="${dispList.startDate}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${dispList.endDate}" pattern="dd/MM/yyyy"/>                                                                        
                                                </div> 

                                                <div class="card-footer">
                                                <button type="button" class="btn btn-primary" onClick="location.href='showUnit.html?c=${Base64.getEncoder().encodeToString(dispList.unit.cod.getBytes())}>&back=hello.html'">
                                                    Veja mais                                                
                                                </button>
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
                               
                        </div>                     
                    </div>                                       
                </div>
                     
            </div>
        </div> 
       
    </div>
</div>
<div class="hd_center_container" style="background: cadetblue">
        <div class="center benefitsBlock"  style="margin-bottom: 0px;" >  
             <div class="row" style="margin-top: 10px !important; margin-bottom: 10px !important; background: white; border-radius: 10px;">
       
            <div class="infoBlock">
                
                    <div class="infoBlockImage"  style="background-image: url(resources/img/shareUnit.jpg)"> </div>
                    <div class="infoBlockText">   
                    <p class="infoBlockTitle text-center"> Benefícios ao Locador TW4R </p>
                    <p class="infoBlockContent"> A oportunidade de transformar sua cota de Time Sharing em um ativo altamente lucrativo. Com a potencialização na visibilidade da sua oferta de locação na rede a TW4R estará lhe garantindo frutos financeiros incomparáveis a qualquer outra opção de investimento. Tudo isso com toda a segurança do sistema TW4R.
 </p>
                   
                    
                         <div style="display:flex; flex-direction: column; align-items: center;">
                            
                        <a href="unit.html">
                        <button class="btn infoBlockBt" type="button" class="btn btn-primary">Cadastre seu Time sharing                    
                        </button>
                        </a>    
                        <button type="button" class="btn infoBlockBt video-btn" data-toggle="modal" data-src="https://www.youtube.com/embed/ZM-ROLzfoYw" data-target="#myModal">
                        Assista o vídeo
                        </button>
                                 
                        </div>     
                            
                    
                    </div>
                    
                   
                
            </div>   

            
        </div>
             <div class="row" style="margin-top: 10px !important; margin-bottom: 10px !important; background: white; border-radius: 10px;">
       
            <div class="infoBlock">
                
                    <div class="infoBlockImage"  style="background-image: url(resources/img/rentUnit.jpg)"> </div>
                    <div class="infoBlockText">   
                    <p class="infoBlockTitle text-center"> Benefícios ao locatário TW4R </p>
                    <p class="infoBlockContent"> A oportunidade de desfrutar seu período de férias em um maravilhoso Resort nos melhores locais turísticos do mundo, com todo o conforto e benefícios inerentes, adquirindo o pacote de diárias por até 30% dos valores de diárias ofertadas pelo hotel e com toda a segurança do sistema TW4R. </p>
                    
                    <center>                        
                        <button class="btn infoBlockBt" type="button" class="btn btn-primary" onclick="submitMainForm();">Alugue um Time Sharing                    
                        </button>                          
                    </center>    
                    </div>
               
            </div>   

            
        </div>
        </div>
</div> 
<div class="hd_center_container" style="background: white">
        <div class="center"  style="margin-top: 0px;" > 
            <p class="infoBlockTitle text-center"> Porque escolher a TW4R </p>
            <div class="row">
            <div class="card-item col-lg-4 col-md-4  col-sm-12 col-xs-12">
                <div class="card card-inverse card-primary text-center"> 
                    <div class="card-block">
                                                <div class="card-header card-red">Facilidade </div>
                                                  
                                                <p class="cardContent"> Com a TW4R você pode encontrar resorts na modalidade time sharing de forma rápida e eficiente. Além disso as operações de alugar ou cadastrar um timesharing são realizadas de forma intuitiva com poucos cliques. </p>     
                                               

                                                           
                                            </div>
                </div>
            </div>    
            <div class="card-item col-lg-4 col-md-4  col-sm-12 col-xs-12">
                <div class="card card-inverse card-primary text-center"> 
                    <div class="card-block">
                                                <div class="card-header card-blue">Baixo Custo </div>
                                                  
                                                <p class="cardContent"> Diferentemente de outras plataformas, a TW4R não cobra anuidade e não obriga o cliente a se tornar sócio para disponibilizar sua unidade de timesharing. </p>     
                                               

                                                           
                                            </div>
                </div>
            </div>    
            <div class="card-item col-lg-4 col-md-4  col-sm-12 col-xs-12">
                <div class="card card-inverse card-primary text-center"> 
                    <div class="card-block">
                                                <div class="card-header card-red">Segurança </div>
                                                  
                                                <p class="cardContent text-center"> Todas as operações realizadas pelo TW4R são seguras, desde o cadastramento das unidade de timesharing onde é exigido a comprovação da propriedade, assim como a realização das reservas, onde o usuário é informado sobre cada etapa do processo. </p>     
                                               

                                                           
                                            </div>
                </div>
            </div>   
            </row>    
            
            
        </div>
        <div class="row centered socialButtons">
            <a target="_blank" href="https://www.facebook.com/topweeks/" class="fa fa-facebook"></a>           
            <a target="_blank" href="https://www.instagram.com/topweeks/" class="fa fa-instagram"></a>                        
        </div>    
</div> 
</div>
    </div>  
    

      
    
</body>

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





