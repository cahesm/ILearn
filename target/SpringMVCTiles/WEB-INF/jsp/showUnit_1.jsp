<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>



<style>
    

@media only screen and (max-width: 36em)
{
    .media { display:block !important;;}
    
    .media img{width: 100% !important; height:230px !important; }
    
}



@media only screen and (max-width: 24em)
{
    .media { display:block !important;;}
    
    .media img{width: 100% !important; height:200px !important; }
    
}

@media (min-width: 550px)
{
    .simple-list .list-item {
        list-style-position: outside;
        font-size: 16px;
        width: 33.333%;
        float: left;
    }
    
}

@media (min-width: 768px)
{
    .simple-list .list-item {
    width: 25%;
    }
}

.simple-list { width: 100%; margin: auto;padding-left: 20px; }
.simple-list ul { list-style-type: none; }
.simple-list .list-item { line-height: 1.6; }
.simple-list .list-item li { display: list-item;}

.simple-list > .list-item::before {
    color: #ed3238;
}
.simple-list>.list-item::before {
    content: "\f00c";
    font-family: FontAwesome;
    margin-right: 8px;
    font-size: 14px;
    line-height: 1;
    -webkit-text-stroke: .6px #fff;
}



.item section{ padding: 10px; background-color: snow; border-top: 1px solid rgba(0, 0, 0, 0.1);}
.item section h5{color: #4765AB !important;}
.item section p{padding: 5px 20px 5px 20px;}
hr{ margin: 0px; padding: 10px;}

.search-box{width:95%; margin:0 auto; }
.listing-block{background:#fff; padding-left: 0px; padding-right: 0px; margin-top:15px;  margin-bottom:15px;}
.item {border:1px solid #bcbcbc;  background:#fff; position:relative;}

.disp{ padding:10px 10px 5px 10px; display: block; }
.disp i{ padding-left:20px;}
.disp button{ margin-left:20px;}
.disp p{ padding-left:20px;}
.disp button{ padding-left:20px;}
.dispDates{
    min-width: 200px;
}
.dispItems
{
    display: flex; flex-wrap: wrap;
}
.map-box{background-color:#A3CCFF;}


                                                           
            .img-item {
                margin-top: 0px;                
                border: 2px solid #dee2e6;
                border-radius: 0.25rem;
                padding: 0px !important;                
                margin-bottom: 15px !important;
                margin-left: 15px !important;
            }
            
            .attributes-grid{
            padding: 10px;
            display: flex !important; 
            display: -webkit-flex;
            flex-direction: row;            
            flex-wrap: wrap;
            }
            
            .attributes-grid li {
            display: block;            
            min-width: 200px;
            color:#888;
}

 .attributes-grid li i {            
            color:black;
}

 

.attribute{
    display: flex;
    flex-wrap: nowrap;
}


.card-text { padding:20px !important; }

.documents-heading {
    background-color: #dee2e6;
    border: 1px;    
}


.documents-title {
    margin-bottom: 0px !important;
    
}

html,
body {
  height: 100%;
}

body {
  display: flex;
  flex-direction: column;
}

.hd_center_container {
  flex-grow: 1;
}

.resort-image {
    background-color: rgba(0,0,0,0.3);
    width: 200px;        
    height: 136px;
    overflow: hidden;
    background-size: cover;
    background-position: center;
}

.carousel-item img{
    width: 100% !important;
}

.text-success{ margin-bottom: 0px !important; }
.text-danger{ margin-bottom: 0px !important; }

.font-14{ font-size: 14px;}
.font-16{ font-size: 16px;}
</style>



<script>
  
 
      //let map: google.maps.Map;  
  
  
//var map;

// Ban Jelačić Square - City Center
//var center = new google.maps.LatLng(45.812897, 15.97706);



/*
function init() 
{

    var mapOptions = {
    zoom: 13,
    center: center,
    mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

    var marker = new google.maps.Marker({
    map: map,
    position: center,
    });
}
*/

function myMap() 
    {
        var loc = document.getElementById("location");
        var locName = document.getElementById("locationName");
        
        var location = {
        "address": loc.value,
        "name": locName.value
        }
        
        var mapProp= {
          center: { lat: -34.397, lng: 150.644 },
          zoom:5
        };
        var map = new google.maps.Map(document.getElementById("map_canvas"),mapProp);
        
        displayLocation( map, location );
    }


function displayLocation(map, location) 
{

    var geocoder = new google.maps.Geocoder();
    var infowindow = new google.maps.InfoWindow();

    var content =   '<div class="infoWindow"><strong>'  + location.name + '</strong>'
    + '<br/>'     + location.address
    + '<br/>'     + location.description + '</div>';

    //if (parseInt(location.lat) == 0) 
    //{
        geocoder.geocode( { 'address': location.address }, function(results, status) 
        {
            if (status == google.maps.GeocoderStatus.OK) 
            {

                map.setCenter(results[0].geometry.location);

                var marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location,
                title: location.name
                });

                google.maps.event.addListener(marker, 'click', function() 
                {
                    infowindow.setContent(content);
                    infowindow.open(map,marker);
                });
            }
        });
    //} 
    /*else 
    {
        var position = new google.maps.LatLng(parseFloat(location.lat), parseFloat(location.lon));
        var marker = new google.maps.Marker({
        map: map,
        position: position,
        title: location.name
        });

        google.maps.event.addListener(marker, 'click', function() 
        {
            infowindow.setContent(content);
            infowindow.open(map,marker);
        });
    }*/
}
 

    let redirectPost = function ( url, data ) 
        {
            var form = document.createElement('form');
            document.body.appendChild(form);
            form.method = 'post';
            form.action = url;
            for (var name in data) {
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = name;
                input.value = data[name];
                form.appendChild(input);
            }
            form.submit();
        }
</script>




<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">   
<div class = "panel-group">
            <div class = "panel panel-default">
                <div class = "panel-heading">
                    <h4 class = "panel-title">
                        <a data-toggle = "collapse" href = "#showUnit">Detalhes da Unidade</a>
                         <a href="${back}">
                        <i class="fa fa-close" style="float:right"></i>
                        </a>
                    </h4>
                </div>
                <div id = "showUnit" class = "panel-collapse expand">
                    <div class = "panel-body">    
                        	
                        <section>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-12 listing-block">
                                         <div class="item-heading">                                             
                                             <div class = "item-cod">
                                                 ${unit.cod}
                                             </div>
                                             <div class = "item-title">
                                                 ${unit.hotel.name}
                                             </div>
                                                                                                                                                                                                                                                                                                                                                                                                                    
                                        </div>  
                                        <div class="item">                                           
                                            <div class="media">                                                                                                
                                                <img class="d-flex align-self-start"        
                                                <c:choose>
                                                <c:when test="${empty unit.medias}">
                                                    src="images/noImage.png"
                                                </c:when>    
                                                <c:otherwise>
                                                   src="${pageContext.request.contextPath}/images/base/hotels/${unit.hotel.medias[0].name}"
                                                </c:otherwise>
                                                </c:choose>        
                                                    
                                                 alt="Generic placeholder image">
                                                <div class="media-body">
                                                    <div class="topInfo" >
                                                        <div class="topInfoTitle"><small>${unit.hotel.address.country}</small></div>
                                                        <div class="topInfoButtons">
                                                            <button class="button social-bt" data-sharer="facebook" data-hashtag="TopWeeksForRent" data-url="${url}/showUnit.html?c=${c}"><i class="fa fa-facebook fa-2 text-primary"></i></button>                                                       
                                                            <button class="button social-bt" data-sharer="whatsapp" data-title="${unit.hotel.name}" data-url="${url}/showUnit.html?c=${c}"><i class="fa fa-whatsapp fa-2 text-success"></i></button>                                                       
                                                        </div> 
                                                    </div>                                                    
                                                    <div class="address">
                                                        <span><i class="fa fa-arrows"></i>${unit.hotel.address.number}, ${unit.hotel.address.address}, ${unit.hotel.address.city}  </span>                                                        
                                                    </div>
                                                     <div class="stats">
                                                        <div><i class="fa fa-square"></i>${unit.room} quartos</div>
                                                        <div><i class="fa fa-hotel"></i>${unit.bedRoom} camas</div>
                                                        <div><i class="fa fa-bath"></i>${unit.bathRoom} banheiros</div>                                                        
                                                        <div><i class="fa fa-users"></i>${unit.person} pessoas</div>                                                        
                                                    </div>
                                                    <c:if test="${ not empty unit.hotel.site}">
                                                    <div class="site">
                                                        <span><i class="fa fa-globe"></i><a href="${unit.hotel.site}" target="_blank">${unit.hotel.site}</a>  </span>                                                        
                                                    </div>
                                                    </c:if> 
                                                    
                                                    
                                                </div>
                                            </div>
                                                   
                                            <section>
                                            <h5>Descrição</h5>
                                            <p class="text-justify font-14"> ${unit.description}</p>
                                            </section>        
                                            <section>
                                            <h5>Disponibilidades</h5>
                                            
                                            <c:choose>
                                                <c:when test="${not empty unit.disponibilities}">

                                                <c:forEach var="disponibilities" items="${unit.disponibilities}">                                                                     
                                                    <div class="disp">
                                                        <div class="dispItems font-14">
                                                            <div class="dispDates">
                                                                <i class="fa fa-calendar"></i><fmt:formatDate value="${disponibilities.startDate}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${disponibilities.endDate}" pattern="dd/MM/yyyy"/>                                                                       
                                                            </div>
                                                            <div><i class="fa fa-moon-o"></i>${disponibilities.nights} noites                                                                      
                                                                 <i>R$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${disponibilities.finalPrice}" /> </i></div>
                                                        </div>    
                                                        
                                                         <c:choose>
                                                        <c:when test = "${disponibilities.status eq 0}">
                                                            
                                                            <button id='rebt' type="button" class="btn btn-primary reservationButton" onclick="location.href = 'addReservation.html?token=${disponibilities.token}&back=showUnit.html?c=${c}%26back=${back}'">Solicitar Reserva
                                                                    
                                                                </button>                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
                                                         </c:when>                                                                         
                                                        <c:otherwise>
                                                           <p class="text-danger">Reservado</p>                                                                                                                                                       
                                                         </c:otherwise>
                                                      </c:choose>
                                                          
                                                        
                                                    </div>                                                                                                                                       
                                                </c:forEach>

                                                </c:when>
                                                <c:otherwise>
                                                    <p class="text-justify font-14"> Nenhuma disponibilidade registrada!<p>
                                                </c:otherwise> 
                                                </c:choose>   
                                            
                                            </section>   
                                            <section>
                                            <h5>Comodidades</h5>
                                            <div class = "attributes-grid">
                                                                                                
                                                <ul class="simple-list clear-fix">                                                  
                                                <c:forEach items="${unit.attributes}" var="atts">
                                                    <li class="list-item">${atts.name}</li>                                                                                                        
                                                </c:forEach>                               
                                                </ul>    
                                            </div>
                                            </section>
                                            <section>
                                            <h5>Cancelamento</h5>
                                            <p class="text-justify font-14"> 
                                                <c:choose>
                                                <c:when test = "${not empty unit.cancelOptions}">
                                                    <c:forEach items="${unit.cancelOptions}" var="cancelOption">
                                                        <c:choose>
                                                        <c:when test = "${cancelOption.devolution eq 100}">
                                                            Antes de ${cancelOption.days} dias para o checkin a devolução será total.
                                                        </c:when>   
                                                        <c:otherwise>        
                                                            Antes de ${cancelOption.days} dias para o checkin a devolução será de ${cancelOption.devolution}%. 
                                                        </c:otherwise>  
                                                        </c:choose>                                                           
                                                        <br>
                                                    </c:forEach>
                                                                                                                                                             
                                                </c:when>
                                                <c:otherwise>        
                                                    Sem opções de cancelamento.
                                                </c:otherwise>   
                                                </c:choose>    
                                                
                                            
                                            </p>
                                            </section>                                                   
                                            <section>
                                            <h5>Mapa</h5>
                                            <input type="hidden" id="location" value="${unit.hotel.address.country} ${unit.hotel.address.city} ${unit.hotel.address.address} ${unit.hotel.address.number} ">
                                            <input type="hidden" id="locationName" value="${unit.hotel.name}">
                                            <div class="mapBox">                                                
                                                <div class="map" id="map_canvas" style="width: 90%; height: 400px;"></div>
                                            </div>
                                            </section> 
                                            
                                            <section>
                                            <h5>Fotos</h5>
                                            <c:choose>
                                                <c:when test="${not empty unit.medias || not empty unit.hotel.medias}">  
                                                    <div class="row media-list">
                                                        <c:forEach items="${unit.medias}" var="medias" varStatus="status">
                                                            <div class="img-item"> 
                                                               <a href="#medias" data-toggle="modal" data-slide-to="${status.index}" > 
                                                               <div class="resort-image" style="background-image: url(${pageContext.request.contextPath}/images/base/units/${medias.name})"> </div>    
                                                                                                                                           
                                                               </a> 
                                                            </div>    
                                                        </c:forEach> 
                                                        <c:forEach items="${unit.hotel.medias}" var="medias" varStatus="status">
                                                            <div class="img-item"> 
                                                               <a href="#medias" data-toggle="modal" data-slide-to="${status.index}" > 
                                                               <div class="resort-image" style="background-image: url(${pageContext.request.contextPath}/images/base/hotels/${medias.name})"> </div>    
                                                                                                                                           
                                                               </a> 
                                                            </div>    
                                                        </c:forEach> 
                                                    </div> 
                                                </c:when>
                                                <c:otherwise>
                                                    <span id="noItemsLabel"> Nenhuma foto registrada!</span>
                                                </c:otherwise> 
                                            </c:choose> 
                                                    
                                                    
                                                    
                                            </section>  
                                            
                                            
                                                  
                                        </div>                      
                                    </div>
                                </div>
                                            
                            </div>
                            
                                    
                                            
                                                 
                        </section>
                        
                    </div>
                                       
                </div>
                                            
            </div>
                                            
        </div>      
                                            
    <script>
        
   
    



        
    $('.item-heading i').click(function(e) {
                   e.preventDefault();
                   $(this).children('form').first().submit();
    });
    
    
    
    $('.nav a').on('click', function (e) {
        e.preventDefault()
        $(this).tab('show')
    });
    
    $('.carousel').on('slide.bs.carousel', function(e) {
  $(this).find('.carousel-inner').animate({
    height: $(e.relatedTarget).height()
  }, 300);
});
    
  </script>
  
</div>
</div>    
                                            
<!-- Modal -->
<div id="medias" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
        <h5 class="modal-title">Fotos</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>  
        <div class="modal-body">
         <div id="carousel" class="carousel slide" data-ride="carousel">



        <!-- The slideshow -->
        <div class="carousel-inner">
          <c:forEach items="${unit.medias}" var="medias" varStatus="status">    
                                                <div ${status.first ? "class='carousel-item active'" : "class='carousel-item'"}>
                                                  <img  src="images/base/units/${medias.name}" alt="First slide">
                                                </div>
                                                </c:forEach>   
          <c:forEach items="${unit.hotel.medias}" var="medias" varStatus="status">    
                                                <div ${status.first && empty unit.medias ? "class='carousel-item active'" : "class='carousel-item'"}>
                                                  <img  src="images/base/hotels/${medias.name}" alt="First slide">
                                                </div>
                                                </c:forEach>   

        </div>

        <!-- Left and right controls -->
        <a class="carousel-control-prev" href="#carousel" data-slide="prev">
          <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#carousel" data-slide="next">
          <span class="carousel-control-next-icon"></span>
        </a>

      </div>   

        </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>                                        
        </div>
      </div>
    </div>
  </div>                                               
                                              
  <script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBDhYZ6ordjANS1dd79moc35qB3VKShjyE&callback=myMap"></script>    

