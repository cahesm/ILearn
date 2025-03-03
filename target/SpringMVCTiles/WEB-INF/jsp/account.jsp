<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<head>
<title>Conta</title>
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



<div class="center-box box-column" style="padding-top: 20px; padding-bottom: 20px; "> 
    <div class="account-box" >
        <div class = "account-title">Conta</div> 
        <div class = "account-form">
    
            <% if(  request.getAttribute("success")!=null ) { %>
            
                <div class="alert alert-success" style="margin:5px;">
                <strong>Alteração realizada com sucesso!</strong>
                </div>                    
          
            <%} else { %>     

    
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
                    
                        
                              
                    <div class="buttonGroup">
                        <center>
                               
                               <button type="button" class="submit-button" onClick="submitMainForm();">Atualizar</button>
                        </center>
                    </div>        
                    
                </form:form>
            
            <%}%> 
        </div>    
    </div>
</div>        
        
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


