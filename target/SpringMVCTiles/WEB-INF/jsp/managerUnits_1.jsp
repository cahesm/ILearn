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
    


.panel-body{
    min-height: 300px !important;
}


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

.hd_center_container {
  flex-grow: 1;
}


  
  

.status{ padding: 10px; font-size: 13px;}

.text-danger{
    margin-bottom: 0px !important;
}
.text-success{
    margin-bottom: 0px !important;
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
        
        function download(dataurl, filename) {
            
        var a = document.createElement("a");
        a.href = dataurl;
        a.setAttribute("download", filename);
        a.click();
        }
        
</script>

</head>

<body>
<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">  
    <form:form id="managerUnitsForm" method="post" action="searchManagerUnits.html" modelAttribute="managerUnitsSearch">              
       <form:hidden  id="cod" path="cod" />        
       <form:hidden  id="page" path="page" /> 
       <form:hidden  id="pages" path="pages" /> 
    </form:form>           
<div class = "panel-group">
            <div class = "panel panel-default">
                <div class = "panel-heading">
                    <h4 class = "panel-title">
                        <span>Unidades</span>                                                                        
                    </h4>
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
                <div id = "unitList" class = "panel-collapse expand">
                    <div class = "panel-body">
                        <div class="input-group p-3">
                            <input id="w-input-search-unit" type="text" class="form-control" placeholder="Procure por código da unidade..." aria-label="Recipient's username" aria-describedby="basic-addon2" value="${managerUnitsSearch.cod}">                        
                            <div class="input-group-append">                          
                            <button id="btSubmit" class="btn btn-outline-secondary" type="button" onclick="searchClick();"><i class="fa fa-search"></i></button>
                        </div>
                        </div>
                        <c:choose>
                        <c:when test="${not empty unitList}">
                        <c:forEach var="unitList" items="${unitList}" varStatus="status">	
                        <section class="section-box">
                            <div class="container-fluid">
                                <div class="row" >
                                    <div class="col-md-12 listing-block">
                                        <div class="item-heading  text-center">
                                             
                                             <div class = "item-cod">
                                                 ${unitList.cod}                 
                                             </div>
                                             <div class = "item-title">
                                                     <a>  ${unitList.hotel.name} </a>                  
                                             </div>
                                            <div class = "item-buttons">
                                                <i class="fa fa-chevron-down float-right" data-toggle="collapse" data-target="#unit${status.index}"></i>                                                
                                            </div>                                                                                                                                                                                                                                                                                                                              
                                        </div>     
                                        <div class="item text-center status">
                                            <c:choose> 
                                            <c:when test="${unitList.validationStatus eq 0 && not empty unitList.documents && unitList.documents[0].status eq 3 }">
                                            <p class="text-danger">   
                                              <strong>Reprovado</strong>
                                            </p>                                                                                
                                            </c:when>                                    
                                            <c:when test="${unitList.validationStatus eq 1}">
                                                <p class="text-success">   
                                                 <strong>Aprovado </strong>
                                               </p>                                        
                                            </c:when>
                                            <c:otherwise>
                                              <p class="text-danger">   
                                              <strong>Não Validado</strong>
                                              </p>  
                                            </c:otherwise>
                                                
                                            </c:choose>
                                        </div> 
                                        <div id="unit${status.index}" class="item panel-collapse collapse">   
                                            
                                            <div class="media">   
                                                
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
                                                            <a href="#" >
                                                            <form action="showUser.html" method="post">
                                                                <input type="hidden" name="id" value=${unitList.idUser} />
                                                                <input type="hidden" name="back" value="managerUnit.html" />
                                                            </form>
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
                                                <c:if test="${unitList.validationStatus eq 0 && not empty unitList.documents && unitList.documents[0].status eq 1 }">
                                                <tr>
                                                    <td colspan="2">    
                                                        <button type="button" id="units${status.index}.btApprove" class="btn btn-primary" onclick=approveUnit(this,'${status.index}')>Aprovar</button>
                                                        <button type="button" id="units${status.index}.btReprove" class="btn btn-secondary" data-toggle="modal" data-target="#addCommentDialog" data-index="${status.index}">Reprovar</button>
                                                    </td>    
                                                </tr>
                                                </c:if>    
                                                </table>	
                                                
                                                
                                            </div>
                                               
                                        </div>                      
                                    </div>
                                </div>
                            </div>
                        </section>
                        </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="emptyList"> Nenhuma unidade encontrada!</div>
                        </c:otherwise> 
                            
                        </c:choose>
                            
                            
                            
                        
                    </div>
                                       
                </div>
                <div class = "panel-footer" style="height: 35px" >
                    <h4 class = "panel-title">   
                        <i  class="fa fa-caret-right caret"  onclick="forward()"></i>  
                        <i  class="records-count"> ( ${managerUnitsSearch.page} de ${managerUnitsSearch.pages} )</i> 
                        <i  class="fa fa-caret-left caret" onclick="backward()"></i>
                        <i  class="records-total"> ${managerUnitsSearch.total} registros </i>                                                        
                    </h4>              
                  
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
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="reproveUnit();">Enviar</button>
                        </div>
                        </div>
                        </div>

                   </div> 
            </div>
        </div>
        <div class="loader"></div>
    <script>
    $('#unitList button').click(function(e) {
                   e.preventDefault();
                   $(this).children('form').first().submit();
    });      
        
    $('#unitList i').click(function(e) {
                   e.preventDefault();
                   $(this).children('form').first().submit();
    });
    
    $('#unitList a').click(function(e) {
        if ( $(this).children('form').length > 0 )
        {
            e.preventDefault();
            $(this).children('form').first().submit();
        }
    });
    
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
   
 
           $('.item-heading i').click(function() { 
    
            $(this).toggleClass('fa fa-chevron-down fa fa-chevron-up'); 
        });    
      
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
   
 /*   
    $('#dropdownMenuButton').click(function(){

       $('#unitListOptions').toggleClass('show');

   });
   */
  </script>
 </div>
 </div> 
    </body>
</html>
