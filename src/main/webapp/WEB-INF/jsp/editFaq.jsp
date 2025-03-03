<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<head>
<meta charset = "utf-8">
<title>Edição de Dúvida</title>
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

<div class="center-box box-column" style="padding-top: 20px; padding-bottom: 20px; "> 
    <c:choose>
    <c:when test="${faq != null}"> 
        <form:form id="faqForm" method="post" modelAttribute="faq" action="updateFaq.html">
            <div class="faq-form-box" >
                <div class = "faq-form-title">Edição de Dúvida</div> 
                <div class = "faq-form-groups">
                    <div class="form-group">
                        <form:hidden id="token" path="token" />
                        <form:hidden  path="idFaq" />
                        <form:label path="question">Dúvida</form:label>
                        <form:textarea path="question" rows="10" cols="30" />
                        <form:errors path="question" cssClass="error"/>
                    </div>  
                    <div class="form-group">
                        <form:label path="answer">Resposta</form:label>
                        <form:textarea path="answer" rows="10" cols="30" />
                        <form:errors path="answer" cssClass="error"/>
                    </div>
                </div>
            </div> 
            <div class="faq-form-box" >
                <div class="buttonGroup">
                    <center>
                        <button type="button" class="btn submit-button" onClick="submitMainForm();">Atualizar</button>
                        <button type="button" class="btn close-button" onClick="location.href = 'managerFaq.html'">Fechar</button>
                    </center>    
                </div>
            </div>
        </form:form>
    </c:when>
    <c:otherwise>      
        <table>       
            <tr>
                    <td>
                        <div class="alert alert-danger">
                        <strong>${message}</strong>
                        </div>                    
                    </td>
            </tr>   
        </table>         
  </c:otherwise>
  </c:choose> 
</div>    

<div class="loader"></div>   

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
