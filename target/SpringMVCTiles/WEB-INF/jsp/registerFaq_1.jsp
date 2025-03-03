<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script language="javascript">
     
 </script>

<html>
<head>
	<title>Registro de Dúvida</title>
        <style>
             .error
            {
                color: #ff0000;
                font-weight: bold;
                font-size: 12px;
            }
            
            .noItemsLabel {
             padding:15px;
         }
            
           
                                        
          .closebt {
                               
            font-size:18px;
          }
         
            .img-item {
                display: flex;                                             
                padding: 0px !important;                
                margin-top: 10px;   
                margin-bottom: 15px !important;
                margin-left: 15px !important;
                margin-right: 10px !important;
            }
            
            .panel-group{
    padding-bottom: 0px;
}

.panel-body{    
    border-radius: 0px 0px 5px 5px;
    background-color: snow !important;
    min-height: 150px;
    border: 1px solid cadetblue !important; 
    border-top: 0px !important;
}

.panel-body table{    
    margin-bottom: 0px !important;
}

.noRadius
{
    border-radius: 0px !important;
}

.noBottomRadius
{
    border-bottom-left-radius:  0px !important;
    border-bottom-right-radius: 0px !important;
}



.centered
{
    justify-content: center;
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
    .buttonGroup button[type="button"]
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

.errorMsg{
    font-size: 12px;
    color: red;    
}

.sucessMsg{
    font-size: 12px;
    color: green;    
}

.modal-header{
    display: block !important;
}

.fa-close, .fa-plus
{
    cursor: pointer;
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
                    <strong>Sucesso!</strong> <%=request.getAttribute("success").toString()%>
                    </div>                     
                </td>
        </tr>   
</table>        
<%} else { %> 

 <form:form id="faqForm" method="post" modelAttribute="faq" action="processFaq.html">
<div class = "panel-group">
    <div class = "panel panel-default">
        <div class = "panel-heading">
            <h4 class = "panel-title">
                 <a data-toggle = "collapse" href = "#faqList">Registro de Dúvida</a>                     
            </h4>
            <div class="panel-buttons">
                <a href="managerFaq.html">
                    <i class="fa fa-close" ></i>
                </a>
            </div>    
        </div> 
        
        <div id = "faqList" class = "collapse show" aria-expanded="true">
            <div class = "panel-body noBottomRadius"> 
                <div class="form-group">
                    <form:label path="question">Dúvida</form:label>
                    <form:textarea path="question" rows="10" cols="30" />
                </div>  
                <div class="form-group">
                    <form:label path="answer">Resposta</form:label>
                    <form:textarea path="answer" rows="10" cols="30" />
                </div>  
                  
                 <div class="buttonGroup">          
                    <button type="button" class="btn btn-primary" onClick="submitMainForm();">Registrar</button>
                    <button type="button" class="btn btn-secondary" onClick="location.href = 'managerFaq.html'">Fechar</button>
                </div>
            </div> 
            
        </div>
    </div>
</div>        
                    
    
</form:form>
  <div class="loader"></div>           
   
<%}%> 

<script>
    
    function submitMainForm()
    {                    
        var spinner = $('.loader');
           
        spinner.show();
           
        document.getElementById("faqForm").submit();
    }
    
    $('#faqForm').submit(function() {
    
    
    return true; // return false to cancel form action
});
    
    </script>
    </div>
</div>
</body>
</html>