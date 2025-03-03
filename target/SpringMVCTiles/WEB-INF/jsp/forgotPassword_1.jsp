<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
	<title>Registro</title>
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

#hd_dashboard_horzmenu{
    max-width: 500px;
     box-shadow: 3px 5px 10px #bbb;
 -webkit-box-shadow: 3px 5px 10px #bbb;
}

.btn{
    width: 150px;
    margin-top: 10px;
}


@media only screen and (max-width: 35.5em)
{
    button[type="button"]
    {
        width: 80%;
    }
    
    .buttonGroup{
        text-align: center !important;;
    }
    
}

.buttonGroup{
        text-align: right;
        padding: 10px 20px 10px 20px;
        
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

input, textarea, select{
    border:none !important;
    border-bottom: 1px solid cadetblue !important;    
    border-radius: 0px !important;
    outline: none !important;        
    background: transparent !important;
    padding: 0px !important;
    margin: 0px !important;
    font-size: 13px;
    
}

textarea{
    padding-top: 10px !important;
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
<body>

<div class="hd_center_container">
<div class="center" id="hd_dashboard_horzmenu">       
    
    <% if(  request.getAttribute("success")!=null ) { %>
    
     <div class="form-group">
        <div class="alert alert-success">
            <strong>Senha enviada com sucesso! Consulte seu email antes de efetuar o login.</strong>
            <a href="login.html">Login</a>
        </div> 
     </div>   
        
    <%} else { %> 

    <div class = "panel-group">
        <div class = "panel panel-default">
            <div class = "panel-heading">
                <h4 class = "panel-title">
                    <a data-toggle = "collapse" href = "#forgotPassword">Recuperação de Senha</a>                 
                </h4>
            </div>
            <div id = "forgotPassword" class = "panel-collapse expand">
                <div class = "panel-body">        
                    <form:form id="forgotPasswordForm" method="post" action="recoverPassword.html" modelAttribute="passwordRecover">
                        <div class="form-group">
                            <form:label path="email">Email</form:label>
                            <form:input path="email"/><form:errors path="email" cssClass="error"/>
                        </div>   
                        <div class="buttonGroup">
                            <button type="button" class="btn btn-primary" onClick="submitMainForm();">Enviar</button>
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
                <div class = "panel-footer"></div>                    
            </div>
        </div>
    </div>      
<%}%> 
<div class="loader"></div>
</div>
</div>
<script>
    function submitMainForm()
    {                          
        var spinner = $('.loader');
            
        spinner.show();
        
        document.getElementById("forgotPasswordForm").submit();
    }
</script>

</body>
</html>