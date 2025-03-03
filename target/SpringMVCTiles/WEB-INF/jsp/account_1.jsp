<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<title>Spring Tiles Contact Form</title>
<style>
    
#hd_dashboard_horzmenu{
    max-width: 500px;
    box-shadow: 3px 5px 10px #bbb;
 -webkit-box-shadow: 3px 5px 10px #bbb;
}

.panel-body{    
    border-radius: 0px 0px 0px 0px;
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

.form-group p{
  font-size: 12px;
  text-align: justify;
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
</head>

<script>
    
    function validate()
    {
        document.location.href = "validate.html";
    }
    
    function submitMainForm()
    {                                 
        document.getElementById("accountForm").submit();
    }
    
</script>

<body>

<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">       
    
<% if(  request.getAttribute("success")!=null ) { %>
<table>       
<tr>
		<td>
                    <div class="alert alert-success">
                    <strong>Alteração realizada com sucesso!</strong>
                    </div>                    
                </td>
        </tr>   
</table>        
<%} else { %>     
<div class = "panel-group">
    <div class = "panel panel-default">
        <div class = "panel-heading">
            <h4 class = "panel-title">
                <a data-toggle = "collapse" href = "#account">Conta do Usuário</a>                 
            </h4>
        </div>
        <div id = "account" class = "panel-collapse expand">
            <div class = "panel-body">        
    
                <form:form id="accountForm" method="post" action="processAccount.html">
                    <div class="form-group">
                                <form:label path="username">Usuário</form:label>
                                <form:input path="username" readonly="true"/>
                           </div>    
                    <div class="form-group">
                                <form:label path="name">Nome Completo</form:label>
                                <form:input path="name" readonly="true"/>
                            </div>   
                    <div class="form-group">
                                <form:label path="email">Email</form:label>
                                <form:input path="email" readonly="true"/>
                            </div>   
                    <div class="form-group">
                                <form:label path="phone">Telefone</form:label>
                                <form:input path="phone"/>
                            </div>    
                    <div class="form-group">
                                <form:label path="password">Senha</form:label>
                                <form:input path="password" type="password" />
                            </div>  
                    <div class="form-group">
                                <form:label path="creation">Data de Criação</form:label>
                                <form:input path="creation" type="datetime" readonly="true"/>
                            </div>   
                    <div class="form-group">
                                <form:label path="owner">Proprietário</form:label>
                                <form:checkbox path="owner"/>
                            </div> 
                    <div class="form-group">
                        
                        <c:choose>
                            <c:when test="${command.validationStatus eq 0 && empty command.validationDoc}">
                                <p class="text-danger">Documento de identicação não validado.</p>
                            </c:when>
                            <c:when test="${command.validationStatus eq 0 && not empty command.validationDoc}">
                                <p class="text-danger">Documento de identificação está sob avaliação, em breve lhe daremos um retorno. </p>
                            </c:when>
                            <c:when test="${command.validationStatus eq 2}">
                                <p class="text-danger">Documento de identicação reprovado: ${command.comment}</p>
                            </c:when>
                            <c:otherwise>
                                <p class="text-success">Documento de identicação aprovado</p>
                            </c:otherwise>
                        </c:choose>
                        
                        <c:if test="${ ( command.validationStatus eq 0 && empty command.validationDoc ) || command.validationStatus eq 2 }">        
                           <p>Valide seu usuário para que suas unidades possam ser listadas nas buscas dos usuários.
                            </p>
                        </c:if>    
                     </div>          
                    <div class="buttonGroup">
                        <center>
                            <c:if test="${ ( command.validationStatus eq 0 && empty command.validationDoc ) || command.validationStatus eq 2 }">
                               <button type="button" class="btn btn-primary" onClick="validate();">Validar</button>
                            </c:if>   
                               <button type="button" class="btn btn-primary" onClick="submitMainForm();">Atualizar</button>
                        </center>
                    </div>        
                    
                </form:form>
            </div>                             
        </div>
    </div>
</div>    
<%}%> 

<div id="modalMessageDialog" class="modal fade" role="dialog">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
              <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title">Message</h5>
                    <input type="hidden" id="index"/>                             
                </div>                                                                    
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>                                        
                </div>
                </div>
                </div>

       </div>   

 <% if(  request.getAttribute("modalMessage") != null ) { %>
       <script>
           
            $("#modalMessageDialog .modal-title").text( "${modalMessage}") ;
        
            $("#modalMessageDialog").modal();  
       </script>
       <%}%>

</div>
</div>
</body>

</html>
