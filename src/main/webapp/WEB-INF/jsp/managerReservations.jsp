<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>

<html>
<head>
<link href="<c:url value="/resources/styles/searchCards.css" />" rel="stylesheet">      
     
        
<style>
    


.isDisabled {
  color: currentColor;
  cursor: not-allowed;
  opacity: 0.5;
  text-decoration: none;
}

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
        
    let onDocSelected = function (index)
    {
        $(".fa fa-plus").prop('disabled',true);

        var spinner = $('.loader');

        var file = document.getElementById('docInput'+index).files[0];
        var idReservation = document.getElementById('reservations'+index+".idReservation").value;

        var fd = new FormData();
        fd.append("multipartFile", file);
        fd.append("idReservation", idReservation);

        spinner.show();

        //var dt = {multipartFile: file};

        // Ajax call for file uploaling
        var ajaxReq = $.ajax(
        {
          url : 'uploadReservationDoc.html',
          type : 'POST',
          data: fd,
          dataType: 'json',
          cache : false,
          contentType : false,
          processData : false,
          xhr: function()
          {
            //Get XmlHttpRequest object
             var xhr = $.ajaxSettings.xhr() ;

            //Set onprogress event handler 
             xhr.upload.onprogress = function(event)
             {
                    var perc = Math.round((event.loaded / event.total) * 100);
                    $('#progressBar').text(perc + '%');
                    $('#progressBar').css('width',perc + '%');
             };
             return xhr ;
            },
            beforeSend: function( xhr ) 
            {
                    //Reset alert message and progress bar
                    $('#alertMsg').text('');
                    $('#progressBar').text('');
                    $('#progressBar').css('width','0%');
            }
        });

        // Called on success of file upload
        ajaxReq.done(function(media) 
        {
          loadDoc( media, index );
          $('#alertMsg').text("Upload realizado com sucesso");
          $('#fileInput').val('');
          $('.fa fa-plus').prop('disabled',false);
          spinner.hide();
        });

        // Called on failure of file upload
        ajaxReq.fail(function(jqXHR) {
          $('#alertMsg').text('('+jqXHR.status+
                    ' - '+jqXHR.statusText+')');
          $('.fa fa-plus').prop('disabled',false);
          spinner.hide();
        });
    };

    let loadDoc = function ( media, index ) 
    {

        let query = "a#docLink"+index;

        $(query).attr("href", "javascript:download('${pageContext.request.contextPath}/documents/base/docs/"+media.name+"', '"+media.alias+"');");
        $(query).removeClass("isDisabled");
        $(query).text( media.alias );

    };


    let approvePayment = function ( el, index )
    {
        var spinner = $('.loader');

        spinner.show();

        var idReservation = document.getElementById('reservations'+index+".idReservation").value;

        redirectPost("approvePayment.html", { idReservation: idReservation });

    };

    let approveVoucher = function ( el, index )
    {
        var spinner = $('.loader');

        spinner.show();

        var idReservation = document.getElementById('reservations'+index+".idReservation").value;

        redirectPost("approveVoucher.html", { idReservation: idReservation });

    };

    let reproveVoucher = function ()
    {
        var spinner = $('.loader');

        spinner.show();

        var index =  $("#addCommentDialog .modal-body #index").val();

        var idReservation = document.getElementById('reservations'+index+".idReservation").value;

        var comment =  $("#addCommentDialog .modal-body #comment").val();

        redirectPost("reproveVoucher.html", { idReservation: idReservation, comment: comment });

    };



    let cancelReservation = function ( el, index )
    {
        var spinner = $('.loader');

        spinner.show();

        var idReservation = document.getElementById('reservations'+index+".idReservation").value;

        redirectPost("cancelReservation.html", { idReservation: idReservation });

    };


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

    function download(dataurl, filename) 
    {

        var a = document.createElement("a");
        a.href = dataurl;
        a.setAttribute("download", filename);
        a.click();
    }
        
    function forward()
    {                
        var page = $("#page").val();
        var pages = $("#pages").val();

        if ( page < pages )
        {
            $("#page").val( ++page );

            document.getElementById("managerReservationsForm").submit();
        }                      
    }   
       
    function backward()
    {                
        var page = $("#page").val();

        if ( page > 1 )
        {
            $("#page").val( --page );
            document.getElementById("managerReservationsForm").submit();
        }                      
    }  
    
    
    function searchClick()
    {
        $( "#cod" ).val( $( "#w-input-search-reservation" ).val() ) ;

        submitMainForm();
    } 
        
                           
    function submitMainForm()
    {                                 
        document.getElementById("managerReservationsForm").submit();
    }
        
</script>

</head>

<div class="center-box box-column" style="padding-top: 20px;padding-bottom: 20px;"> 
    <div class="reservations-box" >
        <form:form id="managerReservationsForm" method="post" action="searchManagerReservations.html" modelAttribute="managerReservationsSearch">              
            <form:hidden  id="cod" path="cod" />        
            <form:hidden  id="page" path="page" /> 
            <form:hidden  id="pages" path="pages" /> 
        </form:form>
        <div class = "reservations-header">
            <div class = "reservations-title">Reservas</div>
            <div class="dropdown pull-right panel-dropdown">
                <a class="btn  dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                 ${ option eq -1  ? 'Todas' 
                 : option eq 0 ? 'Aguardando Aprovação' 
                 : option eq 1 ? 'Aguardando Pagamento' 
                 : option eq 2 ? 'Aguardando Voucher' 
                 : option eq 3 ? 'Completadas' 
                 : option eq 4 ? 'Canceladas' 
                 : option eq 5 ? 'Reprovadas' : ''} 
                </a>

                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                  <a class="dropdown-item" href="managerReservation.html">Todas</a>
                  <a class="dropdown-item" href="managerReservation.html?option=0">Aguardando Aprovação</a>
                  <a class="dropdown-item" href="managerReservation.html?option=1">Aguardando Pagamento</a>    
                  <a class="dropdown-item" href="managerReservation.html?option=2">Aguardando Voucher</a>    
                  <a class="dropdown-item" href="managerReservation.html?option=3">Completadas</a>    
                  <a class="dropdown-item" href="managerReservation.html?option=4">Canceladas</a>    
                  <a class="dropdown-item" href="managerReservation.html?option=5">Reprovadas</a>    
                </div>
            </div>
        </div>    
        <div class="reservation-search-box">                                   
            <input id="w-input-search-reservation" type="text" placeholder="Procure por código da reserva..." aria-label="Recipient's username" aria-describedby="basic-addon2" value="${managerReservationsSearch.cod}">
            <div class="reservation-search-buttons">                          
              <button id="btSubmit" class="reservation-search-button" type="button" onclick="searchClick();"><i class="fa fa-search"></i></button>                  
            </div>
        </div>     
            
        <c:choose>
        <c:when test="${not empty reservationList}">
            <c:forEach var="reservationList" items="${reservationList}" varStatus="status">
                <div class="reservation-box">                                            
                    <div class="reservation-box-header">
                        <div class = "reservation-box-cod">
                            ${reservationList.cod}
                        </div>
                        <div class = "reservation-box-title">
                            ${reservationList.hotel.name}
                        </div>                        
                        <div class = "item-buttons">
                            <i class="fa fa-chevron-down float-right" data-toggle="collapse" data-target="#reservation${status.index}"></i>                                                
                        </div> 
                    </div>
                    <div class="reservation-box-status">
                        <c:choose> 
                            <c:when test="${reservationList.status eq 0}">
                                <p class="text-danger">   
                               Aguardando Aprovação do Proprietário
                               </p>
                            </c:when>  
                            <c:when test="${reservationList.status eq 1}">
                                <p class="text-danger">   
                                Aguardando Pagamento
                                </p>
                            </c:when>
                            <c:when test="${reservationList.status eq 2 && not empty reservationList.voucher && ( reservationList.voucher.status eq 0 or reservationList.voucher.status eq 1)}">
                                <p class="text-danger">   
                                Aguardando Aprovação de Voucher
                                </p>
                            </c:when>  
                            <c:when test="${reservationList.status eq 2}">
                                <p class="text-danger">   
                                Aguardando Envio do Voucher
                                </p>
                            </c:when>  
                            <c:when test="${reservationList.status eq 6}">
                                <p class="text-danger">   
                                Aguardando Análise do Voucher
                                </p>
                            </c:when>  
                            <c:when test="${reservationList.status eq 3}">
                                <p class="text-success">   
                                Completada
                                </p>
                            </c:when>  
                            <c:when test="${reservationList.status eq 4}">
                                <p class="text-danger">   
                                Cancelada
                                </p>
                            </c:when>  
                            <c:when test="${reservationList.status eq 5}">
                                <p class="text-danger">   
                                Reprovada                                               
                                </p>
                            </c:when>  
                        </c:choose>
                    </div>    
                    <div id="reservation${status.index}" class="reservation-box-content panel-collapse collapse"> 
                    
                        <table>
                            <input type="hidden" id="reservations${status.index}.idReservation" value="${reservationList.idReservation}"/>                                                                                                                                                  
                            <tr>
                                    <td>Unidade</td>
                                    <td>
                                        <a href="showUnit.html?c=${Base64.getEncoder().encodeToString(reservationList.unit.cod.getBytes())}>&back=managerReservation.html" >                                        
                                            ${reservationList.unit.cod}    
                                        </a>

                                    </td>     
                            </tr>
                            <tr>
                                    <td>CheckIn</td>
                                    <td ><fmt:formatDate value="${reservationList.startDate}" pattern="dd/MM/yyyy"/> </td>   
                            </tr>    
                            <tr>
                                    <td>Checkout</td>
                                    <td > <fmt:formatDate value="${reservationList.endDate}" pattern="dd/MM/yyyy"/></td>   
                            </tr>   
                            <tr>
                                    <td>Valor</td>
                                    <td> 
                                        R$<fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${reservationList.disponibility.finalPrice}" />
                                    </td>   
                            </tr>   
                            <tr>
                                    <td>Boleto</td>
                                    <td> 
                                        <c:choose>
                                        <c:when test="${not empty reservationList.doc}">
                                           <a id="docLink${status.index}" href="javascript:download('${pageContext.request.contextPath}/documents/base/docs/${reservationList.doc.name}', '${reservationList.doc.alias}');" > ${reservationList.doc.alias} </a>
                                         </c:when>
                                         <c:otherwise>
                                           <a id="docLink${status.index}" class="isDisabled" href="#"> n/d </a>
                                         </c:otherwise>  
                                       </c:choose>   
                                    </td>   
                            </tr>   

                            <tr>
                                    <td>Comprovantes</td>
                                    <td>

                                        <c:choose>
                                        <c:when test="${not empty reservationList.payments}">
                                            <c:forEach var="payments" items="${reservationList.payments}" varStatus="status2">                                            
                                            <a href="javascript:download('${pageContext.request.contextPath}/documents/base/payments/${payments.name}', '${payments.alias}');" > ${payments.alias} </a>                                            
                                            </c:forEach>                                                                                                       
                                        </c:when>        
                                        <c:otherwise>
                                             n/d                                                                                                       
                                        </c:otherwise> 
                                        </c:choose>

                                    </td>   
                            </tr>  
                            <tr>
                                    <td>Voucher</td>
                                    <td>

                                        <c:choose>
                                        <c:when test="${not empty reservationList.voucher}">

                                        <a href="javascript:download('${pageContext.request.contextPath}/documents/base/vouchers/${reservationList.voucher.name}', '${reservationList.voucher.alias}');" > ${reservationList.voucher.alias} </a>

                                        </c:when>
                                        <c:otherwise>
                                            n/d
                                        </c:otherwise> 
                                        </c:choose>

                                    </td>   
                            </tr>  

                            <tr>
                                    <td>Comentário</td>
                                    <td>
                                       <c:choose> 
                                       <c:when test="${not empty reservationList.comment}">
                                         ${reservationList.comment}
                                        </c:when>  
                                        <c:otherwise>
                                         n/d                                                            
                                        </c:otherwise>
                                       </c:choose>
                                    </td>   
                            </tr>                                   
                        </table>
                                    
                        <c:if test="${reservationList.status eq 1 || ( reservationList.status eq 2  && not empty reservationList.voucher && ( reservationList.voucher.status eq 0 or reservationList.voucher.status eq 1) ) }">
                                
                            <input class="form-control" type="file" name="file" id="docInput${status.index}" style="display:none;" onchange="onDocSelected('${status.index}');">
                            
                            <div class="buttonGroup">
                                <center>
                                <c:choose>   
                                   <c:when test="${not empty reservationList.payments && reservationList.status eq 1 }">
                                       <button type="button" id="reservations${status.index}.btApprove" class="btn submit-button" onclick=approvePayment(this,'${status.index}')>Aprovar Pagamento</button>
                                   </c:when> 
                                   <c:when test="${ empty reservationList.payments && reservationList.status eq 1 }">
                                      <button type="button" id="reservations${status.index}.btCancel"  class="btn submit-button" onclick=cancelReservation(this,'${status.index}')>Cancelar Reserva</button> 
                                   </c:when>
                                   <c:when test="${not empty reservationList.voucher && reservationList.status eq 2 && ( reservationList.voucher.status eq 0 or reservationList.voucher.status eq 1 )   }">
                                      <button type="button" id="reservations${status.index}.btApproveVoucher" class="btn submit-button" onclick=approveVoucher(this,'${status.index}')>Aprovar Voucher</button>
                                      <button type="button" id="reservations${status.index}.btReproveVoucher" class="btn submit-button" data-toggle="modal" data-target="#addCommentDialog" data-index="${status.index}">Reprovar Voucher</button>
                                   </c:when>
                                </c:choose>
                                </center>  
                            </div>    

                            <c:if test="${reservationList.status eq 1 }">
                                   <button type="button" id="reservations${status.index}.btSelectDoc" class="btn submit-button" onclick="document.getElementById('docInput${status.index}').click();">Selecionar Boleto</button>
                            </c:if>      
                                
                        </c:if>            
                        
                    </div>    
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="emptyList"> Nenhuma reserva encontrada!</div>
        </c:otherwise>
        </c:choose>
    </div>
            
    <div id="addCommentDialog" class="modal fade position-fixed" role="dialog">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title">Comentário da Reprovação</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                           <span aria-hidden="true">&times;</span>
                    </button>                               
                </div>                                
                <div class="modal-body">                                                                   
                    <input type="hidden" id="index"/>
                    <textarea  class="w-100" wrap="hard" id="comment" ></textarea>                                  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn close-button" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn submit-button" data-dismiss="modal" onclick="reproveVoucher();">Enviar</button>
                </div>
            </div>
        </div>

    </div>        
            
    <div class = "reservation-result-footer" style="height: 35px" >
        <div class = "reservation-result-buttons">             
            <div  class="fa fa-caret-left caret" onclick="backward()"></div>
            <div  class="count"> ( ${managerReservationsSearch.page} de ${managerReservationsSearch.pages} )</div> 
            <div  class="fa fa-caret-right caret"  onclick="forward()"></div>                  
            <div  class="total"> ${managerReservationsSearch.total} registros </div> 
        </div>                                
    </div>        
            
</div>            
            
<div class="loader"></div>
    
<script>
    
    
    
    $(".dropdown-menu a").click(function()
    {
        
        $(".dropdown .btn:first-child").text($(this).text());
        $(".dropdown .btn:first-child").val($(this).text());

   });
                                  
    $('.item-buttons i').click(function() 
    { 
    
        $(this).toggleClass('fa fa-chevron-down fa fa-chevron-up'); 
    });    
   
   
   $('#addCommentDialog').on('show.bs.modal', function(e) 
   {

        //get data-id attribute of the clicked element
        var index = $(e.relatedTarget).data('index');        
        $("#addCommentDialog .modal-body #index").val( index );
    
    });
   
              
   
 /*   
    $('#dropdownMenuButton').click(function(){

       $('#unitListOptions').toggleClass('show');

   });
   */
  </script>
 