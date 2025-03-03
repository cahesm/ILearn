<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
	<title>Spring Tiles Contact Form</title>
        <style>
.error
{
    color: #ff0000;
    font-weight: bold;
    font-size: 12px;
}
            
.panel-body{    
    border-radius: 0px 0px 0px 0px;
    background-color: snow !important;
    min-height: 150px;
    border: 1px solid cadetblue !important;  
    border-top: 0px !important;
}

#hd_dashboard_horzmenu{
    max-width: 500px;
   box-shadow: 3px 5px 10px #bbb;
 -webkit-box-shadow: 3px 5px 10px #bbb;
}




@media only screen and (min-width: 64em)
{
    form button[type="button"]
    {
        width: 200px;       
    }
    
}

@media only screen and (max-width: 63.999em)
{
 form button[type="button"]
    {
        width: 200px;
    }
}

@media only screen and (max-width: 63.999em) and (min-width: 47.51em)
{
    form button[type="button"]
    {
        width: 200px;
    }
    
}

@media only screen and (max-width: 47.5em)
{
    form button[type="button"]
    {
        width: 80%;
    }
    
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

.form-group {
  display: block;
  margin: 0px !important;
  padding: 10px 20px 10px 20px;
  
}

.form-group a{
  font-size: 12px;
}

label{
    margin: 0px !important;
    margin-top: 5px !important;
    color: cadetblue;
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
        
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>

<script>
    function submitMainForm()
    {                                 
        document.getElementById("loginForm").submit();
    }
    
</script>

<body>
<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">       
<div class = "panel-group">
    <div class = "panel panel-default">
        <div class = "panel-heading">
            <h4 class = "panel-title">
                <a data-toggle = "collapse" href = "#login">Login</a>                 
            </h4>
        </div>
        <div id = "login" class = "panel-collapse expand">
            <div class = "panel-body">        
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
                    <div class="form-group">                                                           
                        <div style = "margin-bottom:10px">
                           <a  href="forgotPassword.html">Esqueceu a senha?</a> 
                        </div>
                        <div>
                            <a href="register.html">Registrar</a> 
                        </div>
                    </div>
                    <div class="form-group"> 
                        <center> <button type="button" class="btn btn-primary" onClick="submitMainForm();">Login</button></center>
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
</div>    
</div>
</div>
</body>
</html>
