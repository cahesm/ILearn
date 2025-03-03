<jsp:useBean id="random" class="java.util.Random" scope="application" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ page import="java.util.*" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
<style>
                   
        html,
        body {
          height: 100%;
        }

        body {
          display: flex;
          flex-direction: column;
        }
        
        .card-header {
            background-color: #d6d6d6 !important;
            color: #333 !important;
        }
        .card {
            border: 1px solid #ccc !important;
            background-color: #f5f5f5 !important;
        }
        .btn-outline-primary {
            border-color: #666 !important;
            color: #666 !important;
        }
        .btn-outline-primary:hover {
            background-color: #666 !important;
            color: #fff !important;
        }
        
        .btn-outline-danger {
            border-color: #a00;
            color: #a00;
        }
        .btn-outline-danger:hover {
            background-color: #a00;
            color: #fff;
        }
        
        .page-title {
            width: 100%;
            font-weight: bold;
            font-size: 16px;
            
            display: flex;
            align-items: center;
            justify-content: left;
        }
        
        .no-classes {
            width: 100%;
            text-align: center;
            margin-top: 50px;
        }
        .no-classes img {
            width: 150px;
            margin-bottom: 20px;
        }
        
        .delete-button {
    display: block;
    width: 100%;
    padding: 10px;
    margin-top: 25px;
    margin-bottom: 10px;
    background-color: green;
    color: white;
    border: 1px solid #ccc;
    text-align: left;
    cursor: pointer;
    font-size: 16px;
    border-radius: 5px;
    text-align: center;
}

.processing-popup {
    display: none; /* Oculto por padrão */
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    
    align-items: center;
    justify-content: center;
    z-index: 1000;
}

.popup-content {
    background: white;
    padding: 20px;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
}

.buttonGroup {
        margin-top: 10px;
    }

      </style>
      <script>
       
    var token = "";
    
    function openDeletePopup( t ) {
        token = t;
        document.getElementById("deleteClassPopup").style.display = "flex";
    }

    function closeDeletePopup() {
        token = "";
        document.getElementById("deleteClassPopup").style.display = "none";        
    }
     
    function closeMessagePopup() {
        
        document.getElementById("messagePopup").style.display = "none";        
    }
     
    function openMessagePopup() {
        
        document.getElementById("messagePopup").style.display = "flex";        
    }
        function deleteClass()
        {
            
            redirectPost("deleteClass.html", { token: token });
        }
        
        
        let redirectPost = function ( url, data ) 
        {
            var form = document.createElement('form');
            document.body.appendChild(form);
            form.method = 'post';
            form.action = url;
            for (var name in data) {
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = name;
                input.value = data[name];
                form.appendChild(input);
            }
            form.submit();
        };
        
        
        document.addEventListener("DOMContentLoaded", function() {
        // Verifica se generatedContent tem algum valor e abre a aba "conteúdo"
    <c:if test="${not empty modalMessage}">            
        openMessagePopup();
    </c:if>
    
    });
      </script>    

      
<div class="center-box box-column" style="gap:0;padding-top: 20px;"> 
    <div class="page-title">
    
        <i style='font-size: 14px; padding-right: 5px; padding-top:2px;' class="fas fa-arrow-right"></i> Aulas
    </div>   
    <div class="container mt-4">
        
        <div class="row">
            <c:choose>
                <c:when test="${not empty studyClasses}">
                    <c:forEach var="studyClass" items="${studyClasses}">
                        <div class="col-md-4">
                            <div class="card text-center mb-4 shadow-sm">
                                <div class="card-header">
                                    <h5 class="mb-0">${studyClass.name}</h5>
                                </div>
                                <div class="card-body">
                                    <i class="fas fa-chalkboard-teacher fa-3x"></i>
                                </div>
                                <div class="card-footer d-flex justify-content-between align-items-center">
                                    <small><fmt:formatDate value="${studyClass.creation}" pattern="dd/MM/yyyy" /></small>
                                    <a href="#" class="btn btn-outline-danger me-2" onclick="openDeletePopup('${studyClass.token}')">
                                            <i class="fas fa-trash"></i>
                                    </a>
                                    <a href="showClass.html?token=${studyClass.token}" class="btn btn-outline-primary">
                                        <i class="fas fa-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-classes">
                        <img src="https://cdn-icons-png.flaticon.com/512/4076/4076549.png" alt="Nenhuma aula disponível">
                        <p class="text-center">Nenhuma aula disponível no momento.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div> 
      
 <div id="deleteClassPopup" class="processing-popup" >
    <div class="popup-content" style="width:300px; text-align: left;">
        <h3>Excluir Aula</h3>
        <div class="form-group">
            <label>Deseja realmente excluir a aula? </label>                
        </div>                
        <div style="margin-top: 10px;">
            <button class="delete-button" onclick="deleteClass()">Excluir</button>
            <button style = "width:100%;" class="submit-button" onclick="closeDeletePopup()">Cancelar</button>
        </div>
    </div>
</div>
      
<div id="messagePopup" class="processing-popup" >
    <div class="popup-content" style="width:300px; text-align: left;">
        <h3>${modalMessage}</h3>                        
        <div style="margin-top: 10px;">            
            <button style = "width:100%;" class="submit-button" onclick="closeMessagePopup()">Fechar</button>
        </div>
    </div>
</div>      






 








