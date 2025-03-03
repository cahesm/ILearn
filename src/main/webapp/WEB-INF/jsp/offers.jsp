<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page import="java.util.*" %>

   <head>      
      <title>Busca</title>
      <script src="<c:url value="/resources/scripts/jquery-ui.js" />"></script>
      <link href="<c:url value="/resources/styles/jquery-ui.css" />" rel="stylesheet">
      <link href="<c:url value="/resources/styles/searchCards.css" />" rel="stylesheet">
      
      <style>
                   
        html,
        body {
          height: 100%;
        }

        body {
          display: flex;
          flex-direction: column;
        }

      </style>
      <!-- Javascript -->
      <script>
         $(function() {
            
            $( "#w-input-search" ).autocomplete({
               minLength: 1,
               source: function (request, response) {
                $.ajax({
                type: "POST",
                url:"getOffers.html",
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
                
                resetFilters();
                 
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
            
            
            
         });
         
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
    </head>  

    <div class="center-box box-column" style="padding-top: 20px;"> 
        
        <div class="offers-box" >
            <div class = "offers-title">Busca</div> 
            <div class="panel-buttons">
                <i class="fa fa-sliders" onclick="openFilter();"></i>
            </div>    
            <div class="offers-search-box">
                <input id="w-input-search" type="text" placeholder="Procure por localização ou nome de resort..." aria-label="Recipient's username" aria-describedby="basic-addon2" value="${offers.searchTerm}">
                <div class="offers-search-buttons">                          
                  <button id="btSubmit" class="offers-search-button" type="button" onclick="searchClick();"><i class="fa fa-search"></i></button>
                  <button class="offers-search-button" type="button" onclick="openFilter();"> <i class="fa fa-sliders" ></i></button>
                </div>
            </div>
        </div>
        <div class="offers-result-box">
            <c:choose>
            <c:when test="${not empty dispList}">                                                                                                                                                
            <c:forEach var="dispList" items="${dispList}" varStatus="status">	
                
                <div class="card-item col-lg-4 col-md-6  col-sm-6 col-xs-12">
                    <div class="card card-inverse card-primary text-center">                
                    <div class="resort-image"                                 
                        <c:choose>
                        <c:when test="${empty dispList.unit.hotel.medias}">
                          style="background-image: url(resources/images/noImage.png)"
                        </c:when>    
                        <c:otherwise>
                            style = "background-image: linear-gradient(180deg, rgba(46, 182, 108, 0) 82.81%, #2EB66C 100%), linear-gradient(0deg, rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.2)), url(${pageContext.request.contextPath}/images/base/hotels/${dispList.unit.hotel.medias[0].name})"    
                        </c:otherwise>
                        </c:choose> >            
                     
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
                                R$ <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${dispList.price}"/>                                                                                
                            </div>
                        </div>
                    </div>
                    <div class="resort-desc">
                        ${dispList.unit.description}
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
        <div class = "offers-result-footer" style="height: 35px" >
            <div class = "offers-result-buttons">             
                <div  class="fa fa-caret-left caret" onclick="backward()"></div>
                <div  class="count"> ( ${offers.page} de ${offers.pages} )</div> 
                <div  class="fa fa-caret-right caret"  onclick="forward()"></div>                  
                <div  class="total"> ${offers.total} registros </div> 
            </div>              
                  
        </div>                
                
    </div>    
        
      
        
    <form:form id="offersForm" method="post" action="searchOffers.html" modelAttribute="offers">
        <form:hidden  id="searchTerm" path="searchTerm" />     
        <form:hidden  id="idHotel" path="idHotel" /> 
        <form:hidden  id="idCountry" path="idCountry" /> 
        <form:hidden  id="idState" path="idState" /> 
        <form:hidden  id="idCity" path="idCity" /> 
        <form:hidden  id="idUnit" path="idUnit" /> 
        <form:hidden  id="region" path="region" /> 
        <form:hidden  id="page" path="page" /> 
        <form:hidden  id="pages" path="pages" /> 
       
        <div id="filterBar" class="sidebar filterbar">
  
            <div  class="topbar"> 
                <div>Filtros</div>
                <i class="fa fa-close close-bt" onclick="closeFilter()"></i>               
            </div>

            <div class="container-fluid">  
                <div class="form-group">
                    <form:label class="formLabel" path="room">Checkin</form:label>
                    <form:input path="startDate" type="date" />
                </div> 
                <div class="form-group">
                    <form:label class="formLabel" path="room">Quartos</form:label>
                    <div class="radioGroup select-size">
                        <form:radiobutton path = "room" value = "1" label = "1+" />                    
                        <form:radiobutton path = "room" value = "2" label = "2+" />                    
                        <form:radiobutton path = "room" value = "3" label = "3+" />                    
                        <form:radiobutton path = "room" value = "4" label = "4+" />                    
                        <form:radiobutton path = "room" value = "5" label = "5+" />                    
                    </div>    
                </div> 
                <div class="form-group">
                    <form:label class="formLabel" path="bedRoom">Camas</form:label>
                     <div class="radioGroup select-size">
                        <form:radiobutton path = "bedRoom" value = "1" label = "1+" />
                       <form:radiobutton path = "bedRoom" value = "2" label = "2+" />
                       <form:radiobutton path = "bedRoom" value = "3" label = "3+" />
                       <form:radiobutton path = "bedRoom" value = "4" label = "4+" />
                       <form:radiobutton path = "bedRoom" value = "5" label = "5+" />
                    </div>
                </div> 
                <div class="form-group">
                    <form:label class="formLabel" path="bathRoom">Banheiros</form:label>
                    <div class="radioGroup select-size">
                        <form:radiobutton path = "bathRoom" value = "1" label = "1+" />
                        <form:radiobutton path = "bathRoom" value = "2" label = "2+" />
                        <form:radiobutton path = "bathRoom" value = "3" label = "3+" />
                        <form:radiobutton path = "bathRoom" value = "4" label = "4+" />
                        <form:radiobutton path = "bathRoom" value = "5" label = "5+" />
                    </div>
                </div> 
                <div class="form-group">
                   <form:label class="formLabel" path="person">Pessoas</form:label>
                   <div class="radioGroup select-size">
                        <form:radiobutton path = "person" value = "1" label = "1+" />
                        <form:radiobutton path = "person" value = "2" label = "2+" />
                        <form:radiobutton path = "person" value = "3" label = "3+" />
                        <form:radiobutton path = "person" value = "4" label = "4+" />
                        <form:radiobutton path = "person" value = "5" label = "5+" />
                    </div>
                </div> 
                  
            </div>    
            <center>       
                <div class="buttonGroup">
                    <button type="button" class="btn submit-button" data-dismiss="modal" onclick="searchClick();">Aplicar</button>
                    <button type="button" class="btn close-button" onclick="closeFilter();">Fechar</button>
                </div>
            </center>
        </div>                     
    </form:form>
       
       
   
                    



<script>
          
       $('.card-footer button').click(function(e) {
                   e.preventDefault();
                   $(this).children('form').first().submit();
    });   
          
       function forward()
       {                
           var page = $("#page").val();
           var pages = $("#pages").val();
           
           if ( page < pages )
           {
               $("#page").val( ++page );
                              
               document.getElementById("offersForm").submit();
           }                      
       }   
       
       function backward()
       {                
           var page = $("#page").val();
           
           if ( page > 1 )
           {
               $("#page").val( --page );
               document.getElementById("offersForm").submit();
           }                      
       }  
    
       function searchClick()
        {
            $( "#searchTerm" ).val( $( "#w-input-search" ).val() ) ;
            
            resetFilters();
            submitMainForm();
        } 
    
       function resetFilters()
       {                            
            $( "#idHotel" ).val( 0 );                 
            $( "#idCountry" ).val( 0 );                 
            $( "#idState" ).val( 0 );                 
            $( "#idCity" ).val( 0 );
            $( "#region" ).val( "" );
       }
                
       function submitMainForm()
       {              
           document.getElementById("offersForm").submit();
       }
       
       function showFilter( bt )
       {               
           bt.style.background='orange';
                     
           $("#filterBox").attr("class","search-box show");
       }
       
       function hideFilter()
       {                            
          $("#btShowFilter").css("background-color","transparent");
          $("#filterBox").attr("class","search-box hide");
       }
       
       $('.fav-box i').click(function(e) {
                   e.preventDefault();
                   $(this).parents('form').submit();
    });
    
      $('.reservationButton').click(function(e) {
                   
            e.preventDefault();                       
            redirectPost("addReservation.html", { idDisponibility: $(this).children("input").val() });
                   
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
    
   