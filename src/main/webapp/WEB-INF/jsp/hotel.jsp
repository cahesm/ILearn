<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<script src="<c:url value="/resources/scripts/jquery-ui.js" />"></script>
<link href="<c:url value="/resources/styles/jquery-ui.css" />" rel="stylesheet">    
   
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

<script>
    $(function() 
    {

        $( "#w-input-search-hotel" ).autocomplete({
          minLength: 1,
          source: function (request, response) {
           $.ajax({
           type: "POST",
           url:"getGroupedHotels.html",
           data: {tagName:request.term},
           success: response,
           dataType: 'json',
           minLength: 1,
           delay: 100
               });
           },

            focus: function( event, ui ) {
             //$( "#project" ).val( ui.item.label );
                return false;
            },
            select: function( event, ui ) {

                $( "#term" ).val( ui.item.name );                  

                resetFilters();

                switch( ui.item.term )
                {                       
                    case 'Hotel':                                  
                        $( "#term" ).val( ui.item.name );
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
                }

                submitMainForm();

                return false;
            }
       })

       .data( "ui-autocomplete" )._renderItem = function( ul, item ) {              
          return $( "<li style='width:100%;'>" )                   
               .append( $( "<div class='searchRow' style='width:100%;'>" )                    
               .append( $( "<div class='searchTerm' style='display:table-cell; width:100px'>" ).text( item.term ) )
               .append( $( "<div class='searchValue' style='display:table-cell;'>" ).text( item.name + ' - ( ' + item.occurrences + ' registros )' ) ) )                        
               .appendTo( ul );                       
       };

    });
       
    function newHotel()
    {
        document.location.href = "addHotel.html";
    }
         
    function deleteHotel()
    {
        var idHotel =  $("#deleteHotelDialog .modal-header #index").val();
            
        redirectPost("deleteHotel.html", { id: idHotel });
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
    };  
    
    function forward()
    {                
        var page = $("#page").val();
        var pages = $("#pages").val();

        if ( page < pages )
        {
            $("#page").val( ++page );

            document.getElementById("hotelsForm").submit();
        }                      
    }   

    function backward()
    {                
        var page = $("#page").val();

        if ( page > 1 )
        {
            $("#page").val( --page );
            document.getElementById("hotelsForm").submit();
        }                      
    }  

    function searchClick()
    {
        $( "#term" ).val( $( "#w-input-search-hotel" ).val() ) ;

        resetFilters();
        submitMainForm();
    } 
        
    function resetFilters()
    {                                                        
        $( "#idCountry" ).val( 0 );                 
        $( "#idState" ).val( 0 );                 
        $( "#idCity" ).val( 0 );            
    }

    function submitMainForm()
    {                                 
        document.getElementById("hotelsForm").submit();
    }
                        
</script>

</head>

<form:form id="hotelsForm" method="post" action="searchHotels.html" modelAttribute="hotels">       
       <form:hidden  id="term" path="term" /> 
       <form:hidden  id="idCountry" path="idCountry" /> 
       <form:hidden  id="idState" path="idState" /> 
       <form:hidden  id="idCity" path="idCity" />        
       <form:hidden  id="page" path="page" /> 
       <form:hidden  id="pages" path="pages" /> 
</form:form>

<div class="center-box box-column" style="padding-top: 20px;padding-bottom: 20px;"> 
    <div class="hotels-box" >
        <div class = "hotels-header">
            <div class = "hotels-title">Lista de Hotéis</div>
            <div class = "hotels-buttons">
                <button type="button" class="btn submit-button" onClick="newHotel();">Adicionar Hotel</button>
            </div>
        </div>
        <div class="hotel-search-box">
                <input id="w-input-search-hotel" type="text" placeholder="Procure por localização ou nome de resort..." aria-label="Recipient's username" aria-describedby="basic-addon2" value="${hotels.term}">
                <div class="hotel-search-buttons">                          
                  <button id="btSubmit" class="hotel-search-button" type="button" onclick="searchClick();"><i class="fa fa-search"></i></button>                  
                </div>
        </div>
        
        <c:choose>
        <c:when test="${not empty hotelList}">
            <c:forEach var="hotelList" items="${hotelList}">
                <div class="hotel-box">
                    <div class="hotel-box-header"> 
                       
                        <div class="hotel-box-title"> ${hotelList.name} </div>
                        <div class="hotel-buttons dropdown pull-right">
                            <i class="fa fa-ellipsis-v" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                            </i>

                            <div class="dropdown-menu item-buttons-box" aria-labelledby="dropdownMenuLink">
                              <div onClick="location.href='editHotel.html?token=${hotelList.token}'"><i class="fa fa-edit"  ></i> <a>Editar Hotel </a>  </div>   
                              <div data-toggle="modal" data-target="#deleteHotelDialog" data-index="${hotelList.idHotel}"><i class="fa fa-trash"></i> <a>Excluir Hotel </a></div>                        
                            </div>
                        </div>
                    </div>
                    <div class="hotel-info-box">
                        <img class="d-flex align-self-start"        
                        <c:choose>
                        <c:when test="${empty hotelList.medias}">
                            src="images/noImage.png"
                        </c:when>    
                        <c:otherwise>
                           src="${pageContext.request.contextPath}/images/base/hotels/${hotelList.medias[0].name}"
                        </c:otherwise>
                        </c:choose>        

                         alt="Generic placeholder image"/>
                        
                        <div class="hotel-info-content">
                            
                            <div class="hotel-info-address">
                                <div><i class="fa fa-arrows"></i>${hotelList.address.number}, ${hotelList.address.address}, ${hotelList.address.city} - ${hotelList.address.country}  </div>                                                        
                            </div>
                            
                            <c:if test="${ not empty hotelList.site}">
                            <div class="hotel-info-site">
                                <div><i class="fa fa-globe"></i><a href="${hotelList.site}" target="_blank">${hotelList.site}</a>  </div>                                                                                                                                                                        
                            </div>                                                       
                            </c:if>  
                            
                            
                        </div>    
                    </div> 
                                                                                       
                    <div id="deleteHotelDialog" class="modal fade" role="dialog">
                        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                          <div class="modal-content">

                            <div class="modal-header">
                                <h5 class="modal-title">Deseja realmente excluir o Hotel?</h5>
                                <input type="hidden" id="index"/>                             
                            </div>                                                                    
                            <div class="modal-footer">
                                <button type="button" class="btn close-button" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn submit-button" data-dismiss="modal" onclick="deleteHotel();">Excluir</button>
                            </div>
                            </div>
                        </div>                                
                    </div>   
                            
                    <div id="modalMessageDialog" class="modal fade" role="dialog">
                        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                            <div class="modal-content">
                                
                                <div class="modal-header">
                                    <h5 class="modal-title">Message</h5>
                                    <input type="hidden" id="index"/>                             
                                </div>                                                                    
                                <div class="modal-footer">
                                    <button type="button" class="btn close-button" data-dismiss="modal">Fechar</button>                                        
                                </div>
                            </div>
                        </div>                                
                    </div>                                                      
                </div>
            </c:forEach>                                                                    
            </c:when>
            <c:otherwise>
                <span id="noItemsLabel"> Nenhum hotel registrado!</span>
            </c:otherwise> 
        </c:choose>
                        
    </div>
    <div class = "hotel-result-footer" style="height: 35px" >
        <div class = "hotel-result-buttons">             
            <div  class="fa fa-caret-left caret" onclick="backward()"></div>
            <div  class="count"> ( ${hotels.page} de ${hotels.pages} )</div> 
            <div  class="fa fa-caret-right caret"  onclick="forward()"></div>                  
            <div  class="total"> ${hotels.total} registros </div> 
        </div>              
                  
    </div>        
</div>            
                    
<% if(  request.getAttribute("modalMessage") != null ) { %>
<script>

    $("#modalMessageDialog .modal-title").text( "${modalMessage}") ;

    $("#modalMessageDialog").modal();  
</script>
<%}%>            
                    
<script>
            
    $('#deleteHotelDialog').on('show.bs.modal', function(e) 
    {
        //get data-id attribute of the clicked element
        var index = $(e.relatedTarget).data('index');        
        $("#deleteHotelDialog .modal-header #index").val( index );
    }); 
                                                                                             
</script>   
