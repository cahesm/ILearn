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

            document.getElementById("unitReservationsForm").submit();
        }                      
    }   
       
    function backward()
    {                
        var page = $("#page").val();

        if ( page > 1 )
        {
            $("#page").val( --page );
            document.getElementById("unitReservationsForm").submit();
        }                      
    }  
    
    
    function searchClick()
    {
        $( "#cod" ).val( $( "#w-input-search-reservation" ).val() ) ;

        submitMainForm();
    } 
        
                           
    function submitMainForm()
    {                                 
        document.getElementById("unitReservationsForm").submit();
    }
        
</script>

</head>

<div class="center-box box-column" style="padding-top: 20px;padding-bottom: 20px;"> 
    <div class="reservations-box" >
        <form:form id="unitReservationsForm" method="post" action="searchUnitReservations.html" modelAttribute="unitReservationsSearch">              
            <form:hidden  id="token" path="token" />        
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
                  <a class="dropdown-item" href="unitReservation.html?token=${token}">Todas</a>
                    <a class="dropdown-item" href="unitReservation.html?token=${token}&option=0">Aguardando Aprovação</a>
                    <a class="dropdown-item" href="unitReservation.html?token=${token}&option=1">Aguardando Pagamento</a>    
                    <a class="dropdown-item" href="unitReservation.html?token=${token}&option=2">Aguardando Voucher</a>    
                    <a class="dropdown-item" href="unitReservation.html?token=${token}&option=3">Completadas</a>    
                    <a class="dropdown-item" href="unitReservation.html?token=${token}&option=4">Canceladas</a>    
                    <a class="dropdown-item" href="unitReservation.html?token=${token}&option=5">Reprovadas</a>        
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
                                    
                                    
                        
                    </div>    
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="emptyList"> Nenhuma reserva encontrada!</div>
        </c:otherwise>
        </c:choose>
    </div>
            
            
            
    <div class = "reservation-result-footer" style="height: 35px" >
        <div class = "reservation-result-buttons">             
            <div  class="fa fa-caret-left caret" onclick="backward()"></div>
            <div  class="count"> ( ${unitReservationsSearch.page} de ${unitReservationsSearch.pages} )</div> 
            <div  class="fa fa-caret-right caret"  onclick="forward()"></div>                  
            <div  class="total"> ${unitReservationsSearch.total} registros </div> 
        </div>                                
    </div>        
            
</div>            
            
<div class="loader"></div>

        
<script>

    
    
    $(".dropdown-menu a").click(function(){
        
      $(".dropdown .btn:first-child").text($(this).text());
      $(".dropdown .btn:first-child").val($(this).text());

   });
                                  
    $('.item-buttons i').click(function() 
    { 
    
        $(this).toggleClass('fa fa-chevron-down fa fa-chevron-up'); 
    });    
   
   
   
   
             
   
 /*   
    $('#dropdownMenuButton').click(function(){

       $('#unitListOptions').toggleClass('show');

   });
   */
  </script>
 </div>
 </div> 
    </body>
</html>
