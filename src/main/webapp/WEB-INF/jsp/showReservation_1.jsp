<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>

<html>
    <head>
       
        
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
    

.documents-heading {
    background-color: #dee2e6;
    border: 1px;    
}


.documents-title {
    margin-bottom: 0px !important;
    
}



</style>

<script>
        
        
        
</script>

</head>

<body>
<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">   
<div class = "panel-group">
            <div class = "panel panel-default">
                <div class = "panel-heading">
                    <h4 class = "panel-title">
                        <a data-toggle = "collapse" href = "#reservationList">Detalhes da Reserva</a>  
                        <a href="${back}">
                        <i class="fa fa-close" style="float:right"></i>
                        </a>
                    </h4>
                </div>
                <div id = "reservationList" class = "panel-collapse expand">
                    <div class = "panel-body">    
                        
                        <section class="section-box">
                            <div class="container-fluid">
                                <div class="row" >
                                    <div class="col-md-12 listing-block">
                                        <div class="item-heading  text-center">
                                             
                                             <div class = "item-cod">
                                                 ${reservation.cod}                 
                                             </div>
                                             <div class = "item-title">
                                                     <a>  ${reservation.hotel.name} </a>                  
                                             </div>
                                                                                                                                                                                                                                                                                                                                                                       
                                        </div>     
                                         
                                        <div id="reservation${status.index}" class="item">   
                                            
                                            <div class="media">   
                                                
                                                <table>
                                                                                                                                                 
                                                <tr>
                                                        <td>Código</td>
                                                        <td >${reservation.cod}</td>     
                                                </tr>    
                                                <tr>
                                                        <td>Unidade</td>
                                                        <td>
                                                            <a href="showUnit.html?c=${Base64.getEncoder().encodeToString(reservation.unit.cod.getBytes())}>&back=showReservation.html" >                                        
                                                                ${reservation.unit.cod}    
                                                            </a>
                                                                                                                        
                                                        </td>     
                                                </tr>    
                                                <tr>
                                                        <td>Criação</td>
                                                        <td ><fmt:formatDate value="${reservation.creation}" pattern="dd/MM/yyyy"/> </td>   
                                                </tr>    
                                                <tr>
                                                        <td>CheckIn</td>
                                                        <td ><fmt:formatDate value="${reservation.startDate}" pattern="dd/MM/yyyy"/> </td>   
                                                </tr>    
                                                <tr>
                                                        <td>Checkout</td>
                                                        <td > <fmt:formatDate value="${reservation.endDate}" pattern="dd/MM/yyyy"/></td>   
                                                </tr>    
                                                <tr>
                                                        <td>Valor</td>
                                                        <td >${reservation.disponibility.finalPrice}</td>   
                                                </tr>    
                                                <tr>
                                                        <td>Status</td>
                                                        <td class='text-info'>
                                                            <c:choose> 
                                                           <c:when test="${reservation.status eq 0}">
                                                             <p class="text-danger">   
                                                            <strong>Aguardando Aprovação do Proprietário</strong>
                                                            </p>
                                                            </c:when>  
                                                            <c:when test="${reservation.status eq 1}">
                                                             <p class="text-danger">   
                                                            <strong>Aguardando Pagamento</strong>
                                                            </p>
                                                            </c:when>
                                                            <c:when test="${reservation.status eq 2 && not empty reservation.voucher && ( reservation.voucher.status eq 0 or reservation.voucher.status eq 1)}">
                                                            <p class="text-danger">   
                                                           <strong>Aguardando Aprovação de Voucher</strong>
                                                           </p>
                                                           </c:when>  
                                                            <c:when test="${reservation.status eq 2}">
                                                             <p class="text-danger">   
                                                            <strong>Aguardando Envio do Voucher</strong>
                                                            </p>
                                                            </c:when>  
                                                            <c:when test="${reservation.status eq 3}">
                                                             <p class="text-success">   
                                                            <strong>Concluída</strong>
                                                            </p>
                                                            </c:when>  
                                                            <c:when test="${reservation.status eq 4}">
                                                             <p class="text-danger">   
                                                            <strong>Cancelada</strong>
                                                            </p>
                                                            </c:when>  
                                                            <c:when test="${reservation.status eq 5}">
                                                             <p class="text-danger">   
                                                            <strong>Reprovado</strong>
                                                            <c:if test="${reservation.status eq 5}">
                                                            :    
                                                            ${reservation.comment}

                                                            </c:if>  
                                                            </p>
                                                            </c:when>  
                                                            </c:choose>
                                                        </td>   
                                                </tr>    
                                                <tr>
                                                        <td>Voucher</td>
                                                        <td class='text-info'>
                                                            
                                                            <c:choose>
                                                            <c:when test="${not empty reservation.voucher}">
                                                                                        
                                                            <a href="javascript:download('${pageContext.request.contextPath}/documents/base/vouchers/${reservation.voucher.name}', '${reservation.voucher.alias}');" > ${reservation.voucher.alias} </a>
                                            
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
                                                           <c:when test="${not empty reservation.comment}">
                                                             ${reservation.comment}
                                                            </c:when>  
                                                            <c:otherwise>
                                                             n/d                                                            
                                                            </c:otherwise>
                                                           </c:choose>
                                                        </td>   
                                                </tr>    
                                                </table>	
                                                
                                                
                                            </div>
                                            
                                            
                                             
                                            <div class="tabs-body">
                                                <div class="card text-center">
                                                    <div class="card-header">
                                                        <ul class="nav nav-tabs card-header-tabs" role="tablist">
                                                          <li class="nav-item">
                                                            <a class="nav-link active" href="#payments-${status.index}" role="tab" aria-controls="payments-${status.index}" aria-selected="true">Pagamento</a>
                                                          </li>                                                         
                                                          
                                                        </ul>
                                                      </div>
                                                      <div class="card-body">                                                        
                                                         <div class="tab-content">                                                                                                                   
                                                          <div class="tab-pane active" id="payments-${status.index}" role="tabpanel" aria-labelledby="payments-${status.index}-tab">                                                            
                                                                <input id="idReservation${status.index}" type="hidden"  value="${reservationList.idReservation}" >
                                                                                                                                                                                                                                                                                                                    
                                                                <div id="paymentsListContainer" class="table-responsive" style="display:block">
                                                                <table id="reservationPayments${status.index}" class="table" >
                                                                <thead>    
                                                                <tr>
                                                                    <th>Comprovante</th>
                                                                    <th>Data</th>                                                                                                                                                                                                                                
                                                                </tr>                                  
                                                                </thead>
                                                                <tbody> 
                                                                  <c:forEach items="${reservationList.payments}" var="payments" varStatus="status2">
                                                                    <tr>
                                                                    <input type="hidden" id="payments${status.index}_${status2.index}.idMedia" value="${payments.idMedia}"/>  
                                                                    
                                                                    <td width="60%"> <a href="javascript:download('${pageContext.request.contextPath}/documents/base/payments/${payments.name}', '${payments.alias}');" > ${payments.alias} </a> </td>
                                                                    <td class="text-center" width="40%"> <fmt:formatDate value="${payments.creation}" pattern="dd/MM/yyyy"/> </td>
                                                                    
                                                                    </tr>
                                                                </c:forEach>           
                                                                </tbody>
                                                                </table>
                                                            </div>
                                                          </div>  
                                                        </div>
                                                      </div>
                                                    
                                                </div>
                                            </div>     
                                        </div>                      
                                    </div>
                                </div>
                            </div>
                        </section>
                        
                    </div>
                                       
                </div>
            </div>
        </div>   
           
        
        
        
       
   
</div>
</div>
</body>
</html>
