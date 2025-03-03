<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>        
<title>Registro de Usuário</title>
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
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>

<script>
    function submitMainForm()
    {                                 
        document.getElementById("registerForm").submit();
    }
</script>


<div class="center-box box-column" style="padding-top: 20px; padding-bottom: 20px; "> 
    <div class="account-register-box" >
        <div class = "account-register-title">Registro de Usuário</div> 
        <div class = "account-register-form">
    
            <% if(  request.getAttribute("success")!=null ) { %>
            
                <div class="alert alert-success" style="margin: 20px;">
                <strong>Registro realizado com sucesso!</strong>
                </div>                    
          
            <%} else { %>     

                <form:form id="registerForm" method="post" action="processRegister.html" modelAttribute="user" accept-charset="utf-8">
                    <div class="form-group">
                        <form:label path="username">Usuário</form:label>
                        <form:input path="username"/><form:errors path="username" cssClass="error"/>
                   </div>   
                    <div class="form-group">
                        <form:label path="name">Nome Completo</form:label>
                        <form:input path="name" /><form:errors path="name" cssClass="error"/>
                   </div>   
                    <div class="form-group">
                        <form:label path="email">Email</form:label>
                        <form:input path="email" type="email" /><form:errors path="email" cssClass="error"/>
                   </div>   
                    <div class="form-group">
                        <form:label path="phone">Telefone</form:label>
                        <form:input path="phone" />
                   </div>   
                    <div class="form-group">
                        <form:label path="password">Senha</form:label>
                        <form:input path="password" type="password" /><form:errors path="password" cssClass="error"/>
                   </div>   
                    <div class="form-group">
                        <form:label path="confirmPassword">Confirmar Senha</form:label>
                        <form:input path="confirmPassword" type="password" /><form:errors path="confirmPassword" cssClass="error"/>
                   </div>                          
                   <div class="form-group">
                        <div class="g-recaptcha ml-0" data-sitekey="6LchksMUAAAAAFIhVwc_keUbS600C6qh3JtxruqZ">                                        
                        </div> 
                       <% if(  request.getAttribute("errorCaptcha") != null ) { %>
                            <div class="error"><%=request.getAttribute("errorCaptcha").toString()%></div>
                        <%}%>  
                    </div>
                   <div class="form-group"> 
                        <center> <button type="button" class="submit-button" onClick="submitMainForm();">Registrar</button></center>
                    </div>    
                    
                    <% if(  request.getAttribute("error") != null ) { %>
                    <div class="form-group">    
                        <div class="error">                       
                            <%=request.getAttribute("error").toString()%>
                        </div>
                    </div>        
                    <%}%>
                   
                    
                </form:form>
            <%}%> 
        </div>    
    </div>
</div> 
