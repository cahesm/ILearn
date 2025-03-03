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
        
    let approveUnit = function ( el, index )
    {
        var spinner = $('.loader');

        spinner.show();

        var idUnit = document.getElementById('units'+index+".idUnit").value;

        redirectPost("approveUnit.html", { idUnit: idUnit });

    };

    let reproveUnit = function ()
    {
        var spinner = $('.loader');

        spinner.show();

        var index =  $("#addCommentDialog .modal-body #index").val();

        var idUnit = document.getElementById('units'+index+".idUnit").value;

        var comment =  $("#addCommentDialog .modal-body #comment").val();

        redirectPost("reproveUnit.html", { idUnit: idUnit, comment: comment });

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

            document.getElementById("managerUnitsForm").submit();
        }                      
    }   
       
    function backward()
    {                
        var page = $("#page").val();

        if ( page > 1 )
        {
            $("#page").val( --page );
            document.getElementById("managerUnitsForm").submit();
        }                      
    }  
    
    
    function searchClick()
    {
        $( "#cod" ).val( $( "#w-input-search-unit" ).val() ) ;
        
        submitMainForm();
    } 
        
                           
    function submitMainForm()
    {                                 
        document.getElementById("managerUnitsForm").submit();
    }
        
</script>

</head>

<div class="center-box box-column" style="padding-top: 20px;padding-bottom: 20px;"> 
    <div class="units-box" >
        <form:form id="managerUnitsForm" method="post" action="searchManagerUnits.html" modelAttribute="managerUnitsSearch">              
            <form:hidden  id="cod" path="cod" />        
            <form:hidden  id="page" path="page" /> 
            <form:hidden  id="pages" path="pages" /> 
        </form:form>
        <div class = "units-header">
            <div class = "units-title">Unidades</div>
            <div class="dropdown pull-right panel-dropdown">
                <a class="btn  dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                 ${ option eq -1  ? 'Todas' 
                 : option eq 0 ? 'Não Validadas' 
                 : option eq 1 ? 'Validadas' : ''}      
                </a>

                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <a class="dropdown-item" href="managerUnit.html">Todas</a>
                    <a class="dropdown-item" href="managerUnit.html?option=0">Não Validadas</a>    
                    <a class="dropdown-item" href="managerUnit.html?option=1">Validadas</a>    
                </div>
            </div>
        </div>
        <div class="unit-search-box">                                   
            <input id="w-input-search-unit" type="text" placeholder="Procure por código da unidade..." aria-label="Recipient's username" aria-describedby="basic-addon2" value="${managerUnitsSearch.cod}">
            <div class="hotel-search-buttons">                          
              <button id="btSubmit" class="hotel-search-button" type="button" onclick="searchClick();"><i class="fa fa-search"></i></button>                  
            </div>
        </div>
            
        <c:choose>
        <c:when test="${not empty unitList}">
            <c:forEach var="unitList" items="${unitList}" varStatus="status">
                <div class="unit-box">                                            
                    <div class="unit-box-header">
                        <div class = "unit-box-cod">
                            ${unitList.cod}
                        </div>
                        <div class = "unit-box-title">
                            ${unitList.hotel.name}
                        </div>                        
                        <div class = "item-buttons">
                            <i class="fa fa-chevron-down float-right" data-toggle="collapse" data-target="#unit${status.index}"></i>                                                
                        </div> 
                    </div>
                    <div class="unit-box-status">
                        <c:choose> 
                        <c:when test="${unitList.validationStatus eq 0 && not empty unitList.documents && unitList.documents[0].status eq 3 }">
                            <p class="text-danger">   
                            Reprovado
                            </p>                                                                                
                        </c:when>                                    
                        <c:when test="${unitList.validationStatus eq 1}">
                            <p class="text-success">   
                            Aprovado 
                           </p>                                        
                        </c:when>
                        <c:otherwise>
                            <p class="text-danger">   
                            Não Validado
                            </p>  
                        </c:otherwise>

                        </c:choose>
                    </div>
                    
                    <div id="unit${status.index}" class="unit-box-content panel-collapse collapse">
                        <table>
                            <input type="hidden" id="units${status.index}.idUnit" value="${unitList.idUnit}"/>                                                                                                                                                  
                            <tr>
                                <td>Unidade</td>
                                <td>
                                    <a href="showUnit.html?c=${Base64.getEncoder().encodeToString(unitList.cod.getBytes())}>&back=managerUnit.html" >                                        
                                        ${unitList.cod}    
                                    </a>

                                </td>     
                            </tr>    
                            <tr>
                                <td>Proprietário</td>
                                <td> 
                                    <a href="managerUser.html?c=${Base64.getEncoder().encodeToString(unitList.user.cod.getBytes())}>&back=managerUnit.html" >                                        
                                        ${unitList.user.name}    
                                    </a>
                                                                        
                                </td>   
                            </tr>    
                            <tr>
                                <td>Contrato</td>
                                <td> 
                                <c:choose>
                                    <c:when test="${not empty unitList.documents}">
                                        <a id="validationDocLink${status.index}" href="javascript:download('${pageContext.request.contextPath}/documents/base/units/${unitList.documents[0].name}', '${unitList.documents[0].alias}');" > ${unitList.documents[0].alias} </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a id="validationDocLink${status.index}" class="isDisabled" href="#"> n/d </a>
                                    </c:otherwise>    
                                </c:choose>
                                </td>   
                            </tr>
                            <tr>
                                <td>Criação</td>
                                <td>                                                             
                                    <fmt:formatDate value="${unitList.creation}" pattern="dd/MM/yyyy"/> </td>                                                        
                                </td>   
                            </tr>    

                            <tr>
                                <td>Comentário</td>
                                <td>
                                   <c:choose> 
                                   <c:when test="${unitList.validationStatus eq 0 && not empty unitList.documents && unitList.documents[0].status eq 3 }">

                                       ${unitList.documents[0].comment}

                                 </c:when>   
                                    <c:otherwise>
                                     n/d                                                            
                                    </c:otherwise>
                                   </c:choose>
                                </td>   
                            </tr>                                  
                        </table>
                                
                        <c:if test="${unitList.validationStatus eq 0 && not empty unitList.documents && unitList.documents[0].status eq 1 }">
                            <div class="buttonGroup">
                                <center>     
                                    <button type="button" id="units${status.index}.btApprove" class="btn submit-button" onclick=approveUnit(this,'${status.index}')>Aprovar</button>
                                    <button type="button" id="units${status.index}.btReprove" class="btn close-button" data-toggle="modal" data-target="#addCommentDialog" data-index="${status.index}">Reprovar</button>
                                </center>
                            </div>    
                        </c:if>        
                    </div>    
                </div>        
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="emptyList"> Nenhuma unidade encontrada!</div>
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
                    <button type="button" class="btn submit-button" data-dismiss="modal" onclick="reproveUnit();">Enviar</button>
                </div>
            </div>
        </div>
   
    </div>        

    <div class = "unit-result-footer" style="height: 35px" >
        <div class = "unit-result-buttons">             
            <div  class="fa fa-caret-left caret" onclick="backward()"></div>
            <div  class="count"> ( ${managerUnitsSearch.page} de ${managerUnitsSearch.pages} )</div> 
            <div  class="fa fa-caret-right caret"  onclick="forward()"></div>                  
            <div  class="total"> ${managerUnitsSearch.total} registros </div> 
        </div>                                
    </div>    
</div>            
    
<div class="loader"></div>

<script>
//    $('#unitList button').click(function(e) {
//                   e.preventDefault();
//                   $(this).children('form').first().submit();
//    });      
//        
//    $('#unitList i').click(function(e) {
//                   e.preventDefault();
//                   $(this).children('form').first().submit();
//    });
//    
//    $('.unit-box-content a').click(function(e) {
//        if ( $(this).children('form').length > 0 )
//        {
//            e.preventDefault();
//            $(this).children('form').first().submit();
//        }
//    });
    
    $(".dropdown-menu a").click(function(){
        
      $(".dropdown .btn:first-child").text($(this).text());
      $(".dropdown .btn:first-child").val($(this).text());

   });
        
   $('#addCommentDialog').on('show.bs.modal', function(e) {

        //get data-id attribute of the clicked element
        var index = $(e.relatedTarget).data('index');  
        $("#addCommentDialog .modal-body #index").val( index );
        $("#addCommentDialog .modal-body #comment").val( "" );
   
    }); 
   
 
    $('.item-buttons i').click(function() 
    { 

        $(this).toggleClass('fa fa-chevron-down fa fa-chevron-up'); 
    });    
      
              
   
 /*   
    $('#dropdownMenuButton').click(function(){

       $('#unitListOptions').toggleClass('show');

   });
   */
</script>
 
