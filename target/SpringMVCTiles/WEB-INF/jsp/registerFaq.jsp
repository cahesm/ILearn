<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<head>
<title>Registro de Dúvida</title>
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
    <form:form id="faqForm" method="post" modelAttribute="faq" action="processFaq.html" class="faq-form">
        <div class="faq-form-box" >
            <div class = "faq-form-title">Registro de Dúvida</div> 
            <div class = "faq-form-groups">
                <div class="form-group">
                    <form:label path="question">Dúvida</form:label>
                    <form:textarea path="question" rows="10" cols="30" />
                </div>  
                <div class="form-group">
                    <form:label path="answer">Resposta</form:label>
                    <form:textarea path="answer" rows="10" cols="30" />
                </div>  
                                   
            </div>
        </div>
        <div class="faq-form-box" >
            <div class="buttonGroup">
                <center>
                    <button type="button" class="btn submit-button" onClick="submitMainForm();">Registrar</button>
                    <button type="button" class="btn close-button" onClick="location.href = 'managerFaq.html'">Fechar</button>
                </center>    
            </div>
        </div>    
    </form:form>  
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
