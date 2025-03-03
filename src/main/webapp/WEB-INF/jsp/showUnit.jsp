<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>



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


   

<div class="center-box box-column" style="padding-top: 20px;"> 
    <div class="unit-main-info">
        <div class="unit-top-info">
            <div class = "unit-cod" > Cod. ${unit.cod}</div> 
            <div class = "unit-title" > ${unit.hotel.name}</div> 
        </div> 
        <div class = "unit-location"> 
            ${unit.hotel.address.number}, ${unit.hotel.address.address}, ${unit.hotel.address.city} 
        </div>
    
        <div class="unit-short-info"> 
            <div><i class="fa fa-door-open"></i>${unit.room} quartos</div>
            <div><i class="fa fa-hotel"></i>${unit.bedRoom} camas</div>
            <div><i class="fa fa-bath"></i>${unit.bathRoom} banheiros</div>                                                        
            <div><i class="fa fa-users"></i>${unit.person} pessoas</div>      
        </div>
        
        <img class="d-flex align-self-start" width="100%"        
        <c:choose>
        <c:when test="${empty unit.medias}">
            src="images/noImage.png"
        </c:when>    
        <c:otherwise>
           src="${pageContext.request.contextPath}/images/base/hotels/${unit.hotel.medias[0].name}"
        </c:otherwise>
        </c:choose>        

         alt="Generic placeholder image">
        
        <div class="other-image">
            <c:choose>
                <c:when test="${not empty unit.medias || not empty unit.hotel.medias}">  
                    <div class="unit-short-image-box">
                        
                        <c:forEach items="${unit.medias}" var="medias" varStatus="status">
                            <div class="unit-short-image-item"> 
                               <a href="#medias" data-toggle="modal" data-slide-to="${status.index}" > 
                               <div class="unit-short-image" style="background-image: url(${pageContext.request.contextPath}/images/base/units/${medias.name})"> </div>    

                               </a> 
                            </div>    
                        </c:forEach> 
                        
                        <c:forEach items="${unit.hotel.medias}" var="medias" varStatus="status">
                            <c:if test="${status.index < 3}">
                                <div class="unit-short-image-item"> 
                                   <a href="#medias" data-toggle="modal" data-slide-to="${status.index}" > 
                                   <div class="unit-short-image" style="background-image: url(${pageContext.request.contextPath}/images/base/hotels/${medias.name})"> </div>    

                                   </a> 
                                </div> 
                            </c:if>
                        </c:forEach> 
                        
                    </div> 
                </c:when>                
            </c:choose> 
        </div>  
        
         <div class="unit-reservation-box">
                   
            <div class="unit-reservation-grid" style="padding-top: 5px;">
                <div class="unit-reservation-grid-label"> Períodos Disponíveis: </div>
            </div> 
             <c:choose>
                <c:when test="${not empty unit.disponibilities}">
                    <c:forEach var="disponibilities" items="${unit.disponibilities}">         
                        
                         <div class="unit-reservation-grid">
                            <div class="unit-reservation-grid-period">  
                                <fmt:formatDate value="${disponibilities.startDate}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${disponibilities.endDate}" pattern="dd/MM/yyyy"/>  
                            </div>
                            <div class="unit-reservation-grid-value"> 
                                R$ <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${disponibilities.finalPrice}"/>
                            </div>
                            <div class="unit-reservation-grid-select">  
                                <c:choose>
                                    <c:when test = "${disponibilities.status eq 0}">
                                        <button id='rebt' type="button" class="unit-reservation-button" onclick="location.href = 'addReservation.html?token=${disponibilities.token}&back=showUnit.html?c=${c}%26back=${back}'">Solicitar Reserva</button>    
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-danger">Reservado</p>                                                                                                                                                       
                                    </c:otherwise>    
                                </c:choose>
                                        
                            </div>
                        </div>
                    </c:forEach>  
                </c:when>
                <c:otherwise>                    
                        <p class="text-justify font-14"> Nenhuma disponibilidade registrada!<p>
                </c:otherwise> 
            </c:choose>       
        </div>     
        
        <div class="unit-description-box">
            <div class="unit-description-label"> Descrição </div>
            <div class="unit-description-value"> ${unit.description} </div>
            <div></div>
        </div>  
            
       
            
        <div class="unit-features-box">
            <div class="unit-features-label"> Comodidades </div>
             
            <ul class="simple-list clear-fix">                                                  
                <c:forEach items="${unit.attributes}" var="atts">
                    <li class="list-item">${atts.name}</li>                                                                                                        
                </c:forEach>                               
            </ul>    
            
            
        </div>       
            
        <div class="unit-cancel-box">
            <div class="unit-cancel-label"> Cancelamento </div>
             
            <c:choose>
                <c:when test = "${not empty unit.cancelOptions}">
                    <c:forEach items="${unit.cancelOptions}" var="cancelOption">
                        <div class="unit-cancel-value">
                        <c:choose>
                        <c:when test = "${cancelOption.devolution eq 100}">
                            Antes de ${cancelOption.days} dias para o checkin a devolução será total.
                        </c:when>   
                        <c:otherwise>        
                            Antes de ${cancelOption.days} dias para o checkin a devolução será de ${cancelOption.devolution}%. 
                        </c:otherwise>  
                        </c:choose>   
                        </div>   
                       
                    </c:forEach>

                </c:when>
                <c:otherwise>  
                     <div class="unit-cancel-value">
                    Sem opções de cancelamento.
                    </div>
                </c:otherwise>   
            </c:choose>
            
        </div> 
         
        <input type="hidden" id="location" value="${unit.hotel.address.country} ${unit.hotel.address.city} ${unit.hotel.address.address} ${unit.hotel.address.number} ">
        <input type="hidden" id="locationName" value="${unit.hotel.name}">    
        
        <div class="unit-map-box">
            <div class="unit-map-label"> Localização</div>
                                                          
            <div class="map" id="map_canvas" style="width: 100%; height: 400px;"></div>
            
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

