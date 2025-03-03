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
        <div class="password-message-box">
            <div class="password-message">
                 Senha recuperada com sucesso! Consulte seu email antes de efetuar o login.
            </div> 
             
            <a href="login.html">Clique para voltar ao Login</a>
         </div>        
    <%} else { %> 
    <div class="password-box">
        <div>
            <p class="password-title"> Recuperação de Senha </p>
        </div>
        
        <form:form id="forgotPasswordForm" method="post" action="recoverPassword.html" modelAttribute="passwordRecover">
            
            <div class="form-group">
                <form:label path="email">Email</form:label>
                <form:input path="email"/><form:errors path="email" cssClass="error"/>
            </div>   
            
            <% if(  request.getAttribute("error") != null ) { %>
                <div class="form-group">
                    <div class="error">                       
                        <%=request.getAttribute("error").toString()%>
                    </div>
                </div>        
            <%}%>
            
            <div class="buttonGroup">
                  <center>
                      <button type="button" class="submit-button" onClick="submitMainForm();">Enviar</button>
                  </center>
             </div>

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
        
        document.getElementById("forgotPasswordForm").submit();
    }
</script>

