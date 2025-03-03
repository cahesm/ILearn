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

     .cta-button {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 12px 24px;
        border: 2px solid black;
        border-radius: 10px;
        background: none;
        cursor: pointer;
        font-size: 18px;
        font-weight: bold;
        text-decoration: none;
        color: black;
        gap: 10px;
    }
    .cta-button svg {
        width: 30px;
        height: 30px;
        fill: green;
    }
        
      </style>

      
<div class="center-box box-column" style="padding-top: 20px;"> 
    <h1>Bem-vindo ao ILearn</h1>
        <p>
            O <strong>ILearn</strong> é a plataforma inovadora que utiliza Inteligência Artificial para criar conteúdo 
            e questões personalizadas sobre qualquer tema que você deseja estudar. Seja para concursos públicos, 
            vestibulares ou qualquer outro assunto, nós ajudamos você a aprender de forma eficiente e interativa.
        </p>
        <p>
            Explore um novo jeito de estudar com tecnologia avançada, adaptada às suas necessidades.
        </p>
        <button class="cta-button" onclick="location.href='generator.html'">
        <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M8 5v14l11-7z"/>
        </svg>
        Começar Agora
    </button>
</div>    








