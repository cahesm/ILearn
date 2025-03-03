<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>

<html>
    <head>
    <link href="<c:url value="/resources/styles/searchCards.css" />" rel="stylesheet">      
     
        
<style>
    


.isDisabled {
  color: currentColor;
  cursor: not-allowed;
  opacity: 0.5;
  text-decoration: none;
}

html,
body {
  height: 100%;
}

body {
  display: flex;
  flex-direction: column;
}


</style>

<script>
       
        
    let approveDoc = function ( el, index )
    {
        var spinner = $('.loader');

        spinner.show();

        var idUser = document.getElementById('users'+index+".idUser").value;

        redirectPost("approveUser.html", { idUser: idUser });

    };
        
    let reproveDoc = function ()
    {
        var spinner = $('.loader');

        spinner.show();

        var index =  $("#addCommentDialog .modal-body #index").val();

        var idUser = document.getElementById('users'+index+".idUser").value;

        var comment =  $("#addCommentDialog .modal-body #comment").val();

        redirectPost("reproveUser.html", { idUser: idUser, comment: comment });

    };
        
                
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
        
    function download(dataurl, filename) 
    {            
        var a = document.createElement("a");
        a.href = dataurl;
        a.setAttribute("download", filename);
        a.click();
    }
        
    function forward()
    {                
        var page = $("#page").val();
        var pages = $("#pages").val();

        if ( page < pages )
        {
            $("#page").val( ++page );

            document.getElementById("managerUsersForm").submit();
        }                      
    }   
       
    function backward()
    {                
        var page = $("#page").val();

        if ( page > 1 )
        {
            $("#page").val( --page );
            document.getElementById("managerUsersForm").submit();
        }                      
    }  
    
    
    function searchClick()
    {
        $( "#cod" ).val( $( "#w-input-search-user" ).val() ) ;

        submitMainForm();
    } 
        
                           
    function submitMainForm()
    {                                 
        document.getElementById("managerUsersForm").submit();
    }    
        
</script>

</head>

<div class="center-box box-column" style="padding-top: 20px;padding-bottom: 20px;"> 
    <div class="users-box" >
        <form:form id="managerUsersForm" method="post" action="searchManagerUsers.html" modelAttribute="managerUsersSearch">              
            <form:hidden  id="cod" path="cod" />        
            <form:hidden  id="page" path="page" /> 
            <form:hidden  id="pages" path="pages" /> 
        </form:form>
        <div class = "users-header">
            <div class = "users-title">Usuários</div>
            <div class="dropdown pull-right panel-dropdown">
                <a class="btn  dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                 ${ option eq -1  ? 'Todos' 
                 : option eq 0 ? 'Não validados' 
                 : option eq 1 ? 'Aprovados' 
                 : option eq 2 ? 'Reprovados' 
                 : ''} 
                </a>

                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                  <a class="dropdown-item" href="managerUser.html">Todos</a>
                  <a class="dropdown-item" href="managerUser.html?option=0">Não validados</a>
                  <a class="dropdown-item" href="managerUser.html?option=1">Aprovados</a>                                  
                  <a class="dropdown-item" href="managerUser.html?option=2">Reprovados</a>                                  
                </div>
            </div>
        </div>
        <div class="user-search-box">                                   
            <input id="w-input-search-user" type="text" placeholder="Procure pelo código do usuário..." aria-label="Recipient's username" aria-describedby="basic-addon2" value="${managerUsersSearch.cod}">
            <div class="user-search-buttons">                          
              <button id="btSubmit" class="hotel-search-button" type="button" onclick="searchClick();"><i class="fa fa-search"></i></button>                  
            </div>
        </div>     
        <c:choose>
        <c:when test="${not empty userList}">
            <c:forEach var="userList" items="${userList}" varStatus="status">
                <div class="user-box">                                            
                    <div class="user-box-header">
                        <div class = "user-box-cod">
                            ${userList.cod}
                        </div>
                        <div class = "user-box-title">
                            ${userList.name}
                        </div>                        
                        <div class = "item-buttons">
                            <i class="fa fa-chevron-down float-right" data-toggle="collapse" data-target="#user${status.index}"></i>                                                
                        </div> 
                    </div>
                    <div class="user-box-status">
                        <c:choose> 
                            <c:when test="${userList.validationStatus eq 0}">
                            <p class="text-danger">   
                            Não Validado
                            </p>
                            </c:when>  
                            <c:when test="${userList.validationStatus eq 1}">
                            <p class="text-success">   
                            Aprovado
                            </p>
                            </c:when>                                                
                            <c:when test="${userList.validationStatus eq 2}">
                            <p class="text-danger">   
                            Reprovado
                            </p>
                            </c:when>                                                
                        </c:choose>
                    </div>
                    <div id="user${status.index}" class="user-box-content panel-collapse collapse">
                        <table>
                            <input type="hidden" id="users${status.index}.idUser" value="${userList.idUser}"/>                                                                                                                                                  
                            <tr>
                                    <td>Usuário</td>
                                    <td>                                                            
                                            ${userList.username}                                                                                                                           
                                    </td>     
                            </tr>
                            <tr>
                                    <td>Nome</td>
                                    <td>                                                            
                                            ${userList.name}                                                                                                                           
                                    </td>     
                            </tr>
                            <tr>
                                    <td>Email</td>
                                    <td>                                                            
                                            ${userList.email}                                                                                                                           
                                    </td>     
                            </tr>                                               
                            <tr>
                                    <td>Telefone</td>
                                    <td>                                                            
                                            ${userList.phone}                                                                                                                           
                                    </td>     
                            </tr>
                            <tr>
                                    <td>Criação</td>
                                    <td>                                                            
                                            <fmt:formatDate value="${userList.creation}" pattern="dd/MM/yyyy"/> </td>                                                                                                                          
                                    </td>     
                            </tr>
                            <tr>
                                    <td>Proprietário</td>
                                    <td>                                                            
                                        ${ userList.owner ? 'Sim' : 'Não'}    
                                    </td>     
                            </tr>                                                
                            <tr>
                                    <td>Documento</td>
                                    <td> 
                                        <c:choose>
                                        <c:when test="${not empty userList.validationDoc}">
                                           <a id="docLink${status.index}" href="javascript:download('${pageContext.request.contextPath}/documents/base/users/${userList.validationDoc.name}', '${userList.validationDoc.alias}');" > ${userList.validationDoc.alias} </a>
                                         </c:when>
                                         <c:otherwise>
                                           <a id="docLink${status.index}" class="isDisabled" href="#"> n/d </a>
                                         </c:otherwise>  
                                       </c:choose>   
                                    </td>   
                            </tr>   

                            <tr>
                                    <td>Comentário</td>
                                    <td>
                                       <c:choose> 
                                       <c:when test="${not empty userList.comment}">
                                         ${userList.comment}
                                        </c:when>  
                                        <c:otherwise>
                                         n/d                                                            
                                        </c:otherwise>
                                       </c:choose>
                                    </td>   
                            </tr>                                   
                        </table>
                                    
                        <c:if test="${not empty userList.validationDoc &&  userList.validationDoc.status eq 1  }">
                            <div class="buttonGroup">
                                <center>                                                                                                                       
                                    <button type="button" id="users${status.index}.btApproveDoc" class="btn submit-button" onclick=approveDoc(this,'${status.index}')>Aprovar Doc</button>
                                    <button type="button" id="users${status.index}.btReprove" class="btn close-button" data-toggle="modal" data-target="#addCommentDialog" data-index="${status.index}">Reprovar Doc</button>                                                              
                                </center>
                            </div>    
                        </c:if>            
                                    
                    </div> 
                </div>   
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="emptyList"> Nenhum usuário encontrado!</div>
        </c:otherwise>
        </c:choose>                    
    </div>       
            
    <div id="addCommentDialog" class="modal fade position-fixed" role="dialog">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title">Comentário da Reprovação</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                           <span aria-hidden="true">&times;</span>
                    </button>                               
                </div>                                
                <div class="modal-body">                                                                   
                    <input type="hidden" id="index"/>
                    <textarea  class="w-100" wrap="hard" id="comment" ></textarea>                                  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn close-button" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn submit-button" data-dismiss="modal" onclick="reproveDoc();">Enviar</button>
                </div>
            </div>
        </div>   
    </div>        

    <div class = "user-result-footer" style="height: 35px" >
        <div class = "user-result-buttons">             
            <div  class="fa fa-caret-left caret" onclick="backward()"></div>
            <div  class="count"> ( ${managerUsersSearch.page} de ${managerUsersSearch.pages} )</div> 
            <div  class="fa fa-caret-right caret"  onclick="forward()"></div>                  
            <div  class="total"> ${managerUsersSearch.total} registros </div> 
        </div>                                
    </div>    
</div>        
                
<div class="loader"></div>

<script>
    
    $('#users button').click(function(e) 
    {
        e.preventDefault();
        $(this).children('form').first().submit();
    });      
        
    $('#users i').click(function(e) 
    {
        e.preventDefault();
        $(this).children('form').first().submit();
    });
    
    $('#users a').click(function(e) 
    {
        e.preventDefault();
        $(this).children('form').first().submit();
    });
    
    $(".dropdown-menu a").click(function()
    {        
        $(".dropdown .btn:first-child").text($(this).text());
        $(".dropdown .btn:first-child").val($(this).text());
   });
                                  
    $('.item-buttons i').click(function() 
    {     
        $(this).toggleClass('fa fa-chevron-down fa fa-chevron-up'); 
    });    
   
   
    $('#addCommentDialog').on('show.bs.modal', function(e) 
    {
        //get data-id attribute of the clicked element
        var index = $(e.relatedTarget).data('index');  
        $("#addCommentDialog .modal-body #index").val( index );
        $("#addCommentDialog .modal-body #comment").val( "" );
   
    }); 
   
              
       
       
   
 /*   
    $('#dropdownMenuButton').click(function(){

       $('#unitListOptions').toggleClass('show');

   });
   */
  </script>
 
