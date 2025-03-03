<jsp:useBean id="random" class="java.util.Random" scope="application" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ page import="java.util.*" %>

<style>
                   
        html,
        body {
          height: 100%;
        }

        body {
          display: flex;
          flex-direction: column;
        }
        
    .generatorcontainer {
    display: flex;
    width:100%;
    flex-grow: 1;
}

/* Sidebar (parte oeste) */
.generatorsidebar {
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

.save-button {
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

.tab-button:focus,
.tab-button.active {
  outline: 2px solid black;
}

.tab-button.disabled,
.save-button.disabled{
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
    line-height: 1.6;
}

.main-content {
        
        h1, h2, h3 {
            color: #333;
        }
        p {
            margin-bottom: 15px;
        }
    
}


.tab-content {
    display: none; /* Esconde todas as abas inicialmente */
}

.tab-content.active {
    display: block; /* Mostra a aba ativa */
}

    /* Ajuste do layout para a exibição das abas e conteúdo */
    .generatorform {
        
        width: 100%;
    }

    .buttonGroup {
        margin-top: 10px;
    }
        
    textarea {
            width: 100%;
            height: 100px;
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

.spinner {
    width: 50px;
    height: 50px;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
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
    <c:if test="${not empty sessionScope.generatedContent}">            
        openTab(document.getElementById("contentTab"),'conteudo');
    </c:if>
    <c:if test="${empty sessionScope.generatedContent}">
        openTab(document.getElementById("generatorTab"),'gerador');
    </c:if>
    });
        
        function submitMainForm()
    {
        //var spinner = $('.loader');

        //spinner.show();
        
        document.getElementById("processingPopup").style.display = "flex"; // Mostra o popup

        document.getElementById("generatorForm").submit();
    }
    
    function checkAnswer(questionIndex, isCorrect, explanation) {
    let resultText = isCorrect ? 
        "<span style='color: green; font-weight: bold;'>✔ Resposta correta!</span>" : 
        "<span style='color: red; font-weight: bold;'>✘ Resposta incorreta.</span>";

    resultText += "<br><strong>Explicação:</strong> " + explanation;
    
    document.getElementById("result_" + questionIndex).innerHTML = resultText;
}

function openSavePopup() {
        document.getElementById("saveClassPopup").style.display = "flex";
    }

    function closeSavePopup() {
        document.getElementById("saveClassPopup").style.display = "none";
        document.getElementById("errorMessage").style.display = "none";
    }

    function saveClass() {
        let className = document.getElementById("classNameInput").value.trim();
        if (className === "") {
            document.getElementById("errorMessage").style.display = "block";
            return;
        }

        document.getElementById("hiddenClassName").value = className;
        document.getElementById("saveClassForm").submit();
    }

    </script>

      
<div class="center-box box-column" style="padding-top: 20px;flex-grow: 1;">
    
        <div class="generatorcontainer">
            <div class="generatorsidebar">
                <button id="generatorTab" class="tab-button" onclick="openTab(this,'gerador')">Gerador</button>
                <button id="contentTab" class="tab-button ${empty sessionScope.generatedContent ? 'disabled' : ''}" onclick="openTab(this,'conteudo')">Conteúdo</button>    
                <button class="tab-button ${empty sessionScope.generatedContent ? 'disabled' : ''}" onclick="openTab(this,'questoes')">Questões</button>
                
                <button type="button" class="save-button ${empty sessionScope.generatedContent ? 'disabled' : ''}" onclick="openSavePopup()">Salvar Aula</button>
                
                <form id="saveClassForm" action="saveClass.html" method="post">
                    <input type="hidden" name="className" id="hiddenClassName">
                </form>
            </div>
            
            <div class="main-content">
                <div id="gerador" class="tab-content active">
                    <form id="generatorForm" method="post" action="generate.html" class="generatorform">
                        <h2>Gerador de Conteúdo</h2>
                        <textarea name="topics" rows="10" cols="30" placeholder="Digite os tópicos para gerar conteúdo..."></textarea>
                        <div class="buttonGroup">
                            <center>
                                <button type="button" class="submit-button" onclick="submitMainForm()">Gerar</button>
                            </center>
                        </div> 
                    </form>
                </div>
                <div id="conteudo" class="tab-content">                    
                    <p>${sessionScope.generatedContent}</p>
                </div>

                <div id="questoes" class="tab-content">
                    <h2>Questões Geradas</h2>
                    
                    <c:forEach var="question" items="${sessionScope.questions}" varStatus="qStatus">
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

<div id="processingPopup" class="processing-popup">
    <div class="popup-content">
        <img src="resources/img/ilearnLogo3.png" alt="Processando..." class="spinner">
        <p>Gerando conteúdo, por favor aguarde...</p>
    </div>
</div>

<!-- Popup de salvar aula -->


<div id="saveClassPopup" class="processing-popup" >
    <div class="popup-content" style="width:300px; text-align: left;">
        <h3>Salvar Aula</h3>
        <div class="form-group">
            <label>Nome da aula:</label>    
            <input type="text" id="classNameInput" placeholder="Nome da aula..." />
        </div>        
        <p id="errorMessage" style="size: 12px;color: red; display: none;">O nome da aula é obrigatório.</p>
        <div style="margin-top: 10px;">
            <button class="save-button" onclick="saveClass()">Salvar</button>
            <button style = "width:100%;" class="submit-button" onclick="closeSavePopup()">Cancelar</button>
        </div>
    </div>
</div>






