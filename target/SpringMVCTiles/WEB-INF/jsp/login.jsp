<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
    <title>Login</title>
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
        document.getElementById("loginForm").submit();
    }
    
</script>

<div class="center-box box-column" style="padding-top: 20px;"> 
    <div class="login-box" >
        <div class = "login-title">Login</div> 
        <div class = "login-form">
            <form:form id="loginForm" method="post" action="processLogin.html" modelAttribute="login">
                <div class="form-group">
                    <form:label path="username">Usuário/Email</form:label>
                    <form:input path="username"/><form:errors path="username" cssClass="error"/>
                </div>    
                <div class="form-group">
                    <form:label path="password">Senha</form:label>
                    <form:input path="password" type="password" /><form:errors path="password" cssClass="error"/>
                </div> 
                <div class="form-group">
                    <div class="g-recaptcha ml-0" data-sitekey="6LchksMUAAAAAFIhVwc_keUbS600C6qh3JtxruqZ">                                        
                    </div> 
                   <% if(  request.getAttribute("errorCaptcha") != null ) { %>
                        <div class="error"><%=request.getAttribute("errorCaptcha").toString()%></div>
                    <%}%>  
                </div>
                <div class="link-group">                                                           
                    
                       <a  href="forgotPassword.html">Esqueceu a senha?</a> 
                    
                    
                       <a class="link" href="register.html">Registrar</a> 
                    
                </div>
                <div class="buttonGroup">                    
                    <center> 
                        <button type="button" class="submit-button" onClick="submitMainForm();">Login</button>
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
    </div>
</div>    
