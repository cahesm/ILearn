<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


<head>   
<title>Registro de Reserva</title>
<style>
            
html,body 
{
  height: 100%;
}

body 
{
  display: flex;
  flex-direction: column;
}
   
</style>
</head>


<div class="center-box box-column" style="padding-top: 20px; padding-bottom: 20px; "> 
    <div class="reservation-register-box" >
        <div class = "reservation-register-title">Solicitação de Reserva</div> 
        <div class = "reservation-register-form">
    
            <% if(  request.getAttribute("success")!=null ) { %>
            
                <div class="alert alert-success" style="margin:5px;">
                <strong>Solicitação de reserva realizada com sucesso!</strong>
                </div>                    
          
            <%} else { %>   
            
                <form:form id="reservationForm" method="post" action="processReservation.html" modelAttribute="reservation">
                    <div class = "reservation-register-form-row">
                        <div class="form-property-label">Hotel</div>
                        <div>${hotel.name}</div>
                    </div>

                    <div class = "reservation-register-form-row">
                        <div class="form-property-label">Disponibilidade</div>
                        <div>
                             <form:hidden  path="disponibility.token" />
                             <fmt:formatDate value="${reservation.disponibility.startDate}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${reservation.disponibility.endDate}" pattern="dd/MM/yyyy"/>
                        </div>
                    </div>

                    <div class = "reservation-register-form-row">
                        <div class="form-property-label">Valor</div>
                        <div>${reservation.disponibility.finalPrice}</div>
                    </div>

                    <div class = "reservation-register-form-row">
                        <div class="form-property-label">
                            Data de Início
                        </div>
                        <div>
                            <form:input path="startDate" type="date" />
                            <form:hidden id="idDisponibility" path="idDisponibility" />
                            <form:errors path="startDate" cssClass="error"/>
                        </div>
                    </div>
                    <div class = "reservation-register-form-row">
                        <div class="form-property-label">
                           Data de Fim
                        </div>
                        <div>
                            <form:input path="endDate" type="date" /> 
                            <form:errors path="endDate" cssClass="error"/>
                        </div>
                    </div>    
                                                	                                         
                </form:form>
             <%}%>
             
        </div>
        <div class="reservation-register-buttons">
            <center>
                <button type="button" class="btn submit-button" onClick="submitMainForm();">Registrar</button>
                <button type="button" class="btn close-button" onClick="location.href = '${back}'">Fechar</button>
            </center>
        </div>  
        <div class="loader"></div>   
    </div>
</div>             



<script>
           
    function submitMainForm()
    {           
        $('.loader').show();
        
        document.getElementById("reservationForm").submit();
    }
            
</script>
