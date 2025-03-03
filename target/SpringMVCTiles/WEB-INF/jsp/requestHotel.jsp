<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<head>
<title>Registro</title>
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
        
        
</head>

<div class="center-box box-column" style="padding-top: 20px;">         
    <% if(  request.getAttribute("success")!=null ) { %>
        <div class="hotel-message-box">
            <div class="hotel-message">
                 Requisição de Cadastro de Hotel enviada com sucesso!
            </div> 
             
            
         </div>        
    <%} else { %>
    <div class="hotel-form-box">
        <div>
            <p class="hotel-title"> Requisição para Cadastro de Hotel </p>
        </div>
        
        <form:form method="post" id="requestHotelForm" action="processRequestHotel.html" modelAttribute="hotelRequest">
            <div class="form-group">
                <p> O cadastramento de novos hotéis é realizado de acordo com as demandas de nossos proprietários parceiros. Informe o nome, endereço e o site de seu hotel para que possamos registrá-lo no nosso sistema. 
Assim que o mesmo esteja cadastrado lhe avisaremos por e-mail para que possa continuar o cadastramento de sua unidade.
                </p>
            </div>  
            <div class="form-group">
                   <form:label path="info">Informações do Hotel</form:label>
                   <form:textarea path="info" rows="10" cols="30" />
            </div>  
            <div class="buttonGroup">
                <center>
                    <button type="button" class="btn submit-button" onClick="submitMainForm();">Enviar</button>
                 </center>
            </div>    
                     
            <% if(  request.getAttribute("error") != null ) { %>
            <div class="form-group">  
                   <div class="error">                       
                       <%=request.getAttribute("error").toString()%>
                   </div>
            </div>                 

            <%}%>
                                         
        </form:form>
        
    </div>    
    
<%}%> 

</div>     
<div class="loader"></div>    


<script>
    function submitMainForm()
    {                          
        var spinner = $('.loader');
            
        spinner.show();
        
        document.getElementById("requestHotelForm").submit();
    }
</script>

