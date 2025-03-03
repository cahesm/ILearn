<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<script language="javascript">
     
     </script>

<html>
<head>   
	<title>Registro de Reserva</title>
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
            
.error
{
    color: #ff0000;
    font-weight: bold;
}


.panel-group{
padding-bottom: 10px;
}

.panel-body{    
border-radius: 0px 0px 5px 5px;
}


input{
    border:none !important;
    border-bottom: 1px solid cadetblue !important;    
    border-radius: 0px !important;
    outline: none !important;        
    background: transparent !important;
    padding: 0px !important;
    margin: 0px !important;
    
}

input:focus {
    background: transparent !important;
}

input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
input:-webkit-autofill:active {
    transition: background-color 5000s ease-in-out 0s;
    
}



        </style>
</head>
<body>
<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">   
<% if(  request.getAttribute("success")!=null ) { %>
<table>       
<tr>
		<td>
                     <div class="alert alert-success">
                    <strong>Reserva registrada com sucesso!</strong> 
                    </div>                     
                </td>
        </tr>   
</table>        
<%} else { %> 

 <form:form id="reservationForm" method="post" action="processReservation.html" modelAttribute="reservation">
<div class = "panel-group">
    <div class = "panel panel-default">
        <div class = "panel-heading">
            <h4 class = "panel-title">
                <a data-toggle = "collapse" href = "#reservationList">Registro de Reserva</a> 
                <a href="${back}">
                    <i class="fa fa-close" style="float:right"></i>
                </a>
            </h4>
        </div>
        <div id = "reservationList" class = "panel-collapse expand">
            <div class = "panel-body">                    
                    <table>
                    <tr>
                            <td>Hotel</td>
                            <td class='text-info'>${hotel.name}</td>   
                    </tr>    
                    <tr>
                            <td>Disponibilidade</td>
                            <td class='text-info'>
                                <form:hidden  path="disponibility.token" />
                                <fmt:formatDate value="${reservation.disponibility.startDate}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${reservation.disponibility.endDate}" pattern="dd/MM/yyyy"/>
                            </td>   
                    </tr>    
                    <tr>
                            <td>Valor</td>
                            <td class='text-info'>${reservation.disponibility.finalPrice}</td>   
                    </tr>    
                    <tr>
                            <td><form:label path="startDate">Data de Início</form:label></td>
                            <td><form:input path="startDate" type="date" />
                            <form:hidden id="idDisponibility" path="idDisponibility" />
                            <form:errors path="startDate" cssClass="error"/>
                            </td>   
                    </tr>	        	
                    		
                    <tr>
                            <td><form:label path="endDate">Data de Fim</form:label></td>
                            <td><form:input path="endDate" type="date" /> <form:errors path="endDate" cssClass="error"/></td> 
                    </tr>	
                    
                    <tr>
                        <td colspan="2">
                                 <button type="button" class="btn btn-primary" onClick="submitMainForm();">Registrar</button>
                                 <button type="button" class="btn btn-secondary" onClick="location.href = '${back}'">Fechar</button>
                        </td>
                     </tr>
                                 
                    </table>	

                
            </div> 
        </div>
    </div>
</div>        
   
   
<div class="loader"></div>


</form:form>
            
   
<%}%> 

<script>
           
    function submitMainForm()
    {           
        $('.loader').show();
        
        document.getElementById("reservationForm").submit();
    }
            
    </script>
</div>
</div>
</body>
</html>