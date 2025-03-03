<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<title>Spring Tiles Contact Form</title>
        <style>
            
            #hd_dashboard_horzmenu{
    max-width: 500px;
}
            
           .panel-body{    
    border-radius: 0px 0px 5px 5px;
    background-color: snow !important;
    min-height: 150px;    
    border: 1px solid cadetblue !important;  
    border-top: 0px !important;
    
}

.btn{
    width: 150px;
    margin-top: 10px;
}

@media only screen and (max-width: 35.5em)
{
    form button[type="button"]
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


          
.font-13{ font-size: 14px;}

        </style>
</head>
<body>

<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">    
<div class = "panel-group">
    <div class = "panel panel-default">
        <div class = "panel-heading">
            <h4 class = "panel-title">
                <a data-toggle = "collapse" href = "#account">Usuário</a>    
                <a href="${back}">
                    <i class="fa fa-close" style="float:right"></i>
                </a>
            </h4>
        </div>
        <div id = "account" class = "panel-collapse expand">
            <div class = "panel-body">        
    
                <div class="form-group">
                        <label>Usuário</label>
                        <input type="text" readonly value="${user.username}"/>
                </div>   
                <div class="form-group">
                        <label>Nome Completo</label>
                        <input type="text" readonly value="${user.name}"/>
                </div>   
                <div class="form-group">
                        <label>Email</label>
                        <input type="text" readonly value="${user.email}"/>
                </div>   
                <div class="form-group">
                        <label>Telefone</label>
                        <input type="text" readonly value="${user.phone}"/>
                </div>   
                <div class="form-group">
                        <label>Data de Criação</label>
                        <input type="text" readonly value="${user.phone}"/>
                </div>   
                <div class="form-group">
                        <label>Proprietário</label>
                        <p class="font-13 pt-2">${user.owner ? "Sim" : "Não"}</p>
                </div>   
                                                                  
            </div>                             
        </div>
    </div>
</div>    
</div>
</div>                    
</body>
</html>
