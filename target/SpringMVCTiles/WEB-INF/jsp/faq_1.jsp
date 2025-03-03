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

.hd_center_container {
  flex-grow: 1;
}    
    

.tabs-body { padding: 0.5rem; }

.media{display: flex; padding-bottom: 10px;}



.form-control{ margin: 0px !important; border-radius: 0.25rem !important;; border-color: #6c757d !important;; }

          



.documents-heading {
    background-color: #dee2e6;
    border: 1px;   
    text-align: left;
    font-size: 14px;
    padding: 5px;
}


.documents-title {
    margin-bottom: 0px !important;
    
}





.emptyList { text-align: center; padding:20px !important; display: block; }

.status{ padding: 10px; font-size: 13px;}

.text-danger{
    margin-bottom: 0px !important;
}

.text-success{
    margin-bottom: 0px !important;
}



.font-14{ font-size: 14px;}

.fa-close, .fa-plus{ cursor: pointer !important;}

</style>

<script>
        
        
</script>

</head>

<body>
<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">   
<div class = "panel-group">
            <div class = "panel panel-default">
                <div class = "panel-heading">
                    <h4 class = "panel-title">
                        <a data-toggle = "collapse" href = "#faqList">Dúvidas</a>                         
                    </h4>
                </div>
                <div id = "faqList" class = "panel-collapse expand">
                    <div class = "panel-body">    
                        <c:choose>
                        <c:when test="${not empty faqList}">
                        <c:forEach var="faqList" items="${faqList}" varStatus="status">	
                        <section class="section-box">
                            <div class="container-fluid">
                                <div class="row" >
                                    <div class="col-md-12 listing-block">
                                        <div class="item-heading">
                                             
                                             <div class = "faq-cod">
                                                 ${status.index + 1}                 
                                             </div>
                                             <div class = "faq-title">
                                                     <a>  ${faqList.question} </a>                  
                                             </div>
                                             <div class = "item-buttons">
                                                <i class="fa fa-chevron-down float-right" data-toggle="collapse" data-target="#faq${status.index}"></i>                                                
                                            </div> 
                                                                                                                                                                                                                                                                                                                                                                      
                                        </div>     
                                        
                                        <div id="faq${status.index}" class="item panel-collapse collapse">   
                                            
                                            <div class="faq-text text-justify">   
                                                
                                                ${faqList.answer}
                                                
                                                
                                            </div>
                                                                                                                                                                                      
                                        </div>                      
                                    </div>
                                </div>
                            </div>
                        </section>
                        </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="emptyList"> Nenhuma pergunta registrada!</div>
                        </c:otherwise> 
                        </c:choose>
                    </div>
                                       
                </div>
            </div>
        </div>   
       
     
       <script>
           $('.item-heading i').click(function() { 
    
            $(this).toggleClass('fa fa-chevron-down fa fa-chevron-up'); 
        });    
       </script>    
   
</div>
</div>
</body>
</html>
