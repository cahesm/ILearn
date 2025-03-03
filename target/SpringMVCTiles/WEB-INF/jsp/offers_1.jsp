<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page import="java.util.*" %>
<html>
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

.hd_center_container {
  flex-grow: 1;
}

#hd_dashboard_horzmenu
{
    max-width: 1000px;
}


.form-group {
  display: block;
  margin: 0px !important;
  padding: 0px 20px 20px 20px;
  
}

.form-group-inline {
  display: flex;
  margin: 0px !important;
  padding: 0px 20px 20px 20px;
  align-items: center;
  
}

.form-group a{
  font-size: 12px;
}

.radioGroup{
  font-size: 12px;
  color: black;
  
}




.formLabel{
    margin: 0px !important;
    margin-top: 5px !important;
    margin-bottom: 2px !important;
    color: cadetblue;
    font-size: 13px;
}

.radioGroup label{
  font-size: 12px;
  color: black;  
  margin-left: 2px !important;
  margin-top: 0px !important;
  margin-bottom:  0px !important;
  vertical-align: middle;
}

.modal input, .modal textarea, .modal select{
    border:none !important;
    border-bottom: 1px solid cadetblue !important;    
    border-radius: 0px !important;
    outline: none !important;        
    background: transparent !important;
    padding: 0px !important;
    margin: 0px !important;
    font-size: 13px;
    
}

input[type="radio"]{
  margin: 0px 0px 0px 10px !important;
  vertical-align: middle; 
}



.modal input:focus {
    background: transparent !important;
}

.modal input:-webkit-autofill,
.modal input:-webkit-autofill:hover,
.modal input:-webkit-autofill:focus,
.modal input:-webkit-autofill:active {
transition: background-color 5000s ease-in-out 0s;
    
}

.modal-body
{
    background: snow;
    padding: 0px !important;
}

.modal-header
{
    background: cadetblue;
    padding: 8px !important;
    border-bottom: 2px solid darkolivegreen !important;
}

.modal-footer
{    
    padding: 8px !important;
    
    background: snow !important;
    
    
}

.modal-title
{
    color: white ;
}

.modal-content
{
    background: transparent !important;
}

.close
{
    color: white;
    opacity: 1 !important;    
    padding: 5px 5px 0px 0px !important;
    margin: 0px !important;
}


.font-20{ font-size: 20px;}



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

    <body>
        
    <div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">   
        
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
  
        <a href="#" class="topbar"> 
            Filtros
            <a href="javascript:void(0)" class="closebtn" onclick="closeFilter()">&times;</a>
        </a>

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
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="searchClick();">Aplicar</button>
                <button type="button" class="btn btn-secondary" onclick="closeFilter();">Fechar</button>
            </div>
         </center>
      </div>
       
       
       <div class = "panel-group">
            <div class = "panel panel-default"> 
                <div class = "panel-heading">
                    <h4 class = "panel-title">
                        <a href = "#unitList">Busca</a>                         
                    </h4>
                    <div class="panel-buttons">
                        <i class="fa fa-sliders" onclick="openFilter();"></i>
                    </div>    
                </div>                 
                <div class = "panel-collapse expand">
                    <div class = "panel-body">  
                        
                        <div class="input-group p-3">
                        <input id="w-input-search" type="text" class="form-control" placeholder="Procure por localização ou nome de resort..." aria-label="Recipient's username" aria-describedby="basic-addon2" value="${offers.searchTerm}">
                        <div class="input-group-append">                          
                          <button id="btSubmit" class="btn btn-outline-secondary" type="button" onclick="searchClick();"><i class="fa fa-search"></i></button>
                        </div>
                      </div>
                        
                        
                        
                        
                        
                      
                                                                                                                        
                       
                       
                    </div>
                                       
                </div>
            </div>
        </div>  
       </form:form>
       <div class = "panel-group">
            <div class = "panel panel-default">
                <div class = "panel-heading">
                    <h4 class = "panel-title">
                        <a href = "#unitList">Ofertas</a>                        
                                                
                        
                                         
                    </h4>
                </div>
                <div id = "unitList" class = "panel-collapse expand">
                    <div class = "panel-body">  
                       <div class="container noSidePadding">

  <div class="row">
    <c:choose>
    <c:when test="${not empty dispList}">                                                                                                                                                
    <c:forEach var="dispList" items="${dispList}" varStatus="status">	
        <div class="card-item col-lg-4 col-md-6  col-sm-6 col-xs-12">
            <div class="card card-inverse card-primary text-center">
                
              <div class="resort-image"                                
              <c:choose>
                <c:when test="${empty dispList.unit.hotel.medias}">
                    style="background-image: url(images/noImage.png)"
                </c:when>    
                <c:otherwise>
                   style="background-image: url(${pageContext.request.contextPath}/images/base/hotels/${dispList.unit.hotel.medias[0].name})"
                </c:otherwise>
                </c:choose>             
                 > </div>
              <div class="card-block">
                <div class="card-header">${dispList.unit.hotel.name} </div>
                <div class="card-location">${dispList.unit.hotel.address.city}, ${dispList.unit.hotel.address.country}</div>
                <h5 class="price-value">R$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${dispList.finalPrice}" /> </h5>                                                
                <div class="card-days">${dispList.nights} noites (R$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${dispList.finalPrice/dispList.nights}" />/noite)</div>    
                                                 
                    <div class="card-dates text-center">    
                        <i class="fa fa-calendar"></i><fmt:formatDate value="${dispList.startDate}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${dispList.endDate}" pattern="dd/MM/yyyy"/>                                                                        
                    </div>                        
                
                
                <div class="card-footer">
                <button type="button" class="btn btn-primary" onClick="location.href='showUnit.html?c=${Base64.getEncoder().encodeToString(dispList.unit.cod.getBytes())}>&back=offers.html'">
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
                <div class = "panel-footer" style="height: 35px" >
                    <h4 class = "panel-title">             
                        <i  class="fa fa-caret-right caret"  onclick="forward()"></i>  
                        <i  class="records-count"> ( ${offers.page} de ${offers.pages} )</i> 
                        <i  class="fa fa-caret-left caret" onclick="backward()"></i>
                        <i  class="records-total"> ${offers.total} registros </i> 
                    </h4>              
                  
                </div>        
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
    
    </html>