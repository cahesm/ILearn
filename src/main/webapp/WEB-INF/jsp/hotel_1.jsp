<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
    <head>
    <script src="<c:url value="/resources/scripts/jquery-ui.js" />"></script>
    <link href="<c:url value="/resources/styles/jquery-ui.css" />" rel="stylesheet">    
   
<style>
    
 @media only screen and (min-width: 36.1em)
{    
    .item-heading
    {
        text-align: center !important;
    }
    
}

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
   
    
    
.ui-menu-item .ui-menu-item-wrapper.ui-state-active {
            background: #6693bc !important;
            
            } 
          
          .searchTerm {
        
        
        border: solid gray;
        border-width: 0px 1px 0px 0px;
        padding: 5px;
        font-weight: bold;
        color: black;
          }
          
          .searchValue {        
        padding: 5px;
        
          }
          
          
          
         
          ul.ui-autocomplete {
    border-radius:10px;
    border:1px solid #DDD;
    margin:10px;
    
}

ul.ui-autocomplete li:last-child {
    padding:7px;
}

ul.ui-autocomplete li:not(:last-child) {
    padding:7px;
    border-bottom:1px solid #DDD;
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
         
.panel-group{
    padding-bottom: 5px;
}

</style>

<script>
         $(function() {
            
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
        }  
        
        
         
      </script>

</head>

<body>
<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">   
<form:form id="hotelsForm" method="post" action="searchHotels.html" modelAttribute="hotels">       
       <form:hidden  id="term" path="term" /> 
       <form:hidden  id="idCountry" path="idCountry" /> 
       <form:hidden  id="idState" path="idState" /> 
       <form:hidden  id="idCity" path="idCity" />        
       <form:hidden  id="page" path="page" /> 
       <form:hidden  id="pages" path="pages" /> 
</form:form>        
    
<div class = "panel-group">
            <div class = "panel panel-default">
                <div class = "panel-heading">
                    <h4 class = "panel-title">
                        <a data-toggle = "collapse" href = "#hotelList">Lista de Hotéis</a>                       
                    </h4>
                    <div class="panel-buttons">
                        <a href="addHotel.html">
                        <i class="fa fa-plus"></i>
                        </a>
                    </div>    
                </div>                
                <div id = "hotelList" class = "panel-collapse expand">
                    <div class = "panel-body">  
                        <div class="input-group p-3">
                            <input id="w-input-search-hotel" type="text" class="form-control" placeholder="Procure por localização ou nome de resort..." aria-label="Recipient's username" aria-describedby="basic-addon2" value="${hotels.term}">                        
                            <div class="input-group-append">                          
                            <button id="btSubmit" class="btn btn-outline-secondary" type="button" onclick="searchClick();"><i class="fa fa-search"></i></button>
                        </div>
                        </div>
                        <c:choose>
                        <c:when test="${not empty hotelList}">
                        <c:forEach var="hotelList" items="${hotelList}">
                         
                        <section class="search-box">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-12 listing-block">
                                        <div class="item-heading">                                                                                          
                                             <div class = "item-title">
                                                 ${hotelList.name}
                                             </div>
                                             <div class="item-buttons dropdown pull-right">
                                                <i class="fa fa-ellipsis-v" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                
                                                </i>

                                                <div class="dropdown-menu item-buttons-box" aria-labelledby="dropdownMenuLink">
                                                  
                                                  <div onClick="location.href='editHotel.html?token=${hotelList.token}'"><i class="fa fa-edit"  ></i> <a>Editar Hotel </a>  </div>   
                                                  <div data-toggle="modal" data-target="#deleteHotelDialog" data-index="${hotelList.idHotel}"><i class="fa fa-trash"></i> <a>Excluir Hotel </a></div>                        
                                                </div>
                                              </div>
                                                                                                                                                                                                                                                                                                                                                                        
                                        </div>                                                                           
                                        <div class="item">
                                            
                                            <div class="media">                                                                                                
                                                <img class="d-flex align-self-start"        
                                                <c:choose>
                                                <c:when test="${empty hotelList.medias}">
                                                    src="images/noImage.png"
                                                </c:when>    
                                                <c:otherwise>
                                                   src="${pageContext.request.contextPath}/images/base/hotels/${hotelList.medias[0].name}"
                                                </c:otherwise>
                                                </c:choose>        
                                                    
                                                 alt="Generic placeholder image">
                                                <div class="media-body">
                                                    <div class="price" ><small>${unitList.hotel.address.country}</small></div>                                                    
                                                    <div class="address">
                                                        <span><i class="fa fa-arrows"></i>${hotelList.address.number}, ${hotelList.address.address}, ${hotelList.address.city}  </span>                                                        
                                                    </div>
                                                    <c:if test="${ not empty hotelList.site}">
                                                    <div class="site">
                                                        <span><i class="fa fa-globe"></i><a href="${hotelList.site}" target="_blank">${hotelList.site}</a>  </span>                                                        
                                                    </div>
                                                    </c:if> 
                                                </div>
                                            </div>
                                            
                                                                                       
                                        </div>                      
                                    </div>
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
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="deleteHotel();">Excluir</button>
                                    </div>
                                    </div>
                                    </div>
                                
                           </div>  
                              <div id="deleteHotelDialog" class="modal fade" role="dialog">
                                <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                                  <div class="modal-content">
                                
                                    <div class="modal-header">
                                        <h5 class="modal-title">Deseja realmente excluir Hotel?</h5>
                                        <input type="hidden" id="index"/>                             
                                    </div>                                                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="deleteHotel();">Excluir</button>
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
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>                                        
                                    </div>
                                    </div>
                                    </div>
                                
                           </div>                        
                        </section>
                        </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="emptyList"> Nenhum hotel registrado!</div>
                        </c:otherwise> 
                        </c:choose>
                    </div>                                      
                </div>
                <div class = "panel-footer" style="height: 35px" >
                    <h4 class = "panel-title">             
                        <i  class="fa fa-caret-right caret"  onclick="forward()"></i>  
                        <i  class="records-count"> ( ${hotels.page} de ${hotels.pages} )</i> 
                        <i  class="fa fa-caret-left caret" onclick="backward()"></i>
                        <i  class="records-total"> ${hotels.total} registros </i> 
                    </h4>              
                  
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
            
           $('#deleteHotelDialog').on('show.bs.modal', function(e) {

        //get data-id attribute of the clicked element
        var index = $(e.relatedTarget).data('index');        
        $("#deleteHotelDialog .modal-header #index").val( index );

    
}); 
            
                   
           $('.item-heading i').click(function(e) {
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
        </div>
        </div>            
    </body>
</html>
