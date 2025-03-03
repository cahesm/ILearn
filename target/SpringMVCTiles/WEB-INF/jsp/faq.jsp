<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>

<html>
    <head>
       
        
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
    <div class="faqs-box" >
        <div class = "faqs-title">Dúvidas</div>                                
        <c:choose>
        <c:when test="${not empty faqList}">
        <c:forEach var="faqList" items="${faqList}" varStatus="status">	
        <div class="faq-item-box">

            <div class="faq-item-top">
                 <div class = "faq-item-cod">
                     ${status.index + 1}                 
                 </div>
                 <div class = "faq-item-title">
                         <a>  ${faqList.question} </a>                  
                 </div>
                 <div class = "item-buttons">
                    <i class="fa fa-chevron-down float-right" data-toggle="collapse" data-target="#faq${status.index}"></i>                                                
                </div> 
            </div>     

            <div id="faq${status.index}" class="faq-item-content panel-collapse collapse">   
                <div class="faq-text text-justify">   
                    ${faqList.answer}
                </div>
            </div>                      
        </div>
        </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="emptyList"> Nenhuma pergunta registrada!</div>
        </c:otherwise> 
        </c:choose>
    </div>                                                   
</div>

 <script>
           $('.item-buttons i').click(function() { 
    
            $(this).toggleClass('fa fa-chevron-down fa fa-chevron-up'); 
        });    
</script>    

