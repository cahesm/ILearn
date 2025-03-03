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
        
    .classcontainer {
    display: flex;
    width:100%;
    flex-grow: 1;
}

/* Sidebar (parte oeste) */
.classsidebar {
    min-width: 180px; /* Largura fixa para a área das abas */
    
    padding: 20px;
    
}

.tab-button {
    display: block;
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    background-color: #ddd;
    border: 1px solid #ccc;
    text-align: left;
    cursor: pointer;
    font-size: 16px;
    border-radius: 5px;
}


.tab-button:focus,
.tab-button.active {
  outline: 2px solid black;
}

.tab-button.disabled{
    cursor: not-allowed;
    opacity: 0.5;
    pointer-events: none; /* Impede o clique */
}

.tab-button:hover {
    background-color: #ccc;
}

/* Main Content (parte central) */
.main-content {
    
    flex-grow: 1; /* Ocupa o espaço restante */
    padding: 20px;
    background-color: #ffffff;
    text-align: justify;
    
}

.tab-content {
    display: none; /* Esconde todas as abas inicialmente */
}

.tab-content.active {
    display: block; /* Mostra a aba ativa */
}

    /* Ajuste do layout para a exibição das abas e conteúdo */
    
    .buttonGroup {
        margin-top: 10px;
    }
        
        
        .question-box {
    border: 1px solid #ccc;
    padding: 15px;
    margin-bottom: 10px;
    border-radius: 5px;
}
.answer-result {
    margin-top: 10px;
    font-size: 14px;
}

.crumble {
            width: 100%;
            font-weight: bold;
            font-size: 16px;
            
            display: flex;
            align-items: center;
            justify-content: left;
        }
        
   


      </style>
      <script>

function openTab(tab,tabName) {
    // Esconde todos os conteúdos das abas
    var contents = document.querySelectorAll('.tab-content');
    contents.forEach(function(content) {
        content.classList.remove('active');
    });
    
    var tabs = document.querySelectorAll('.tab-button');
    tabs.forEach(function(t) {
        t.classList.remove('active');
    });

    // Exibe o conteúdo da aba selecionada
    document.getElementById(tabName).classList.add('active');
    tab.classList.add('active');
}

    // Inicia com a aba 'gerador' aberta
    document.addEventListener("DOMContentLoaded", function() {
        // Verifica se generatedContent tem algum valor e abre a aba "conteúdo"
                
        openTab(document.getElementById("contentTab"),'conteudo');
    
    });
        
    
    
    function checkAnswer(questionIndex, isCorrect, explanation) {
    let resultText = isCorrect ? 
        "<span style='color: green; font-weight: bold;'>✔ Resposta correta!</span>" : 
        "<span style='color: red; font-weight: bold;'>✘ Resposta incorreta.</span>";

    resultText += "<br><strong>Explicação:</strong> " + explanation;
    
    document.getElementById("result_" + questionIndex).innerHTML = resultText;
}


    </script>

      
<div class="center-box box-column" style="padding-top: 20px;flex-grow: 1;">
    <div class="crumble">
        <a href='classes.html'>
         <i style='font-size: 14px; padding-right: 5px; padding-top:1px;' class="fas fa-arrow-right"></i> Aulas
        </a>
        <i style='font-size: 14px; padding-left: 5px;;padding-right: 5px; padding-top:1px;' class="fas fa-arrow-right"></i> ${className}
    </div>
        <div class="classcontainer">
            <div class="classsidebar">
                
                <button id="contentTab" class="tab-button" onclick="openTab(this,'conteudo')">Conteúdo</button>    
                <button class="tab-button" onclick="openTab(this,'questoes')">Questões</button>
                
                
                
            </div>
            
            <div class="main-content">
                
                <div id="conteudo" class="tab-content active">                    
                    <p>${generatedContent}</p>
                </div>

                <div id="questoes" class="tab-content">
                    <h2>Questões Geradas</h2>
                    
                    <c:forEach var="question" items="${generatedQuestions}" varStatus="qStatus">
                        <div class="question-box">
                            <p><strong>Pergunta ${qStatus.index + 1}:</strong> ${question.question}</p>

                            <ul>
                            <c:choose>
                                <c:when test="${not empty question.answers}">    
                                <c:forEach var="answer" items="${question.answers}" varStatus="oStatus">
                                <li>
                                    <input type="radio" name="question_${qStatus.index}" 
                                       id="option_${qStatus.index}_${oStatus.index}" 
                                       value="${answer.isCorrect}"
                                       onclick="checkAnswer(${qStatus.index}, ${answer.isCorrect}, '${question.answer}')">
                                    <label for="option_${qStatus.index}_${oStatus.index}">${answer.answer}</label>
                                </li>
                                </c:forEach>
                                </c:when>
                            </c:choose>    
                            </ul>

                            <p id="result_${qStatus.index}" class="answer-result"></p>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    
</div>    
          
    
<div class="loader"></div> 







