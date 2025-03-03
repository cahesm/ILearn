<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
    <head>
    <script src="<c:url value="/resources/scripts/jquery-ui.js" />"></script>
    <link href="<c:url value="/resources/styles/jquery-ui.css" />" rel="stylesheet">    
   
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

<script>
         
    function newFaq()
    {
        document.location.href = "addFaq.html";
    }
                  
    function deleteFaq()
    {
        var idFaq =  $("#deleteFaqDialog .modal-header #index").val();

        redirectPost("deleteFaq.html", { id: idFaq });
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
    }  
    
    function forward()
    {                
        var page = $("#page").val();
        var pages = $("#pages").val();

        if ( page < pages )
        {
            $("#page").val( ++page );

            document.getElementById("faqsForm").submit();
        }                      
    }   
       
    function backward()
    {                
        var page = $("#page").val();

        if ( page > 1 )
        {
            $("#page").val( --page );
            document.getElementById("faqsForm").submit();
        }                      
    }  
                    
    function resetFilters()
    {                                                        
         $( "#idCountry" ).val( 0 );                 
         $( "#idState" ).val( 0 );                 
         $( "#idCity" ).val( 0 );            
    }
                           
    function submitMainForm()
    {                                 
        document.getElementById("faqsForm").submit();
    }
                        
</script>

</head>


<div class="center-box box-column" style="padding-top: 20px;padding-bottom: 20px;"> 
    <div class="faqs-box" >
        <form:form id="faqsForm" method="post" action="searchFaqs.html" modelAttribute="faqs">              
            <form:hidden  id="page" path="page" /> 
            <form:hidden  id="pages" path="pages" /> 
        </form:form>
        <div class = "faqs-header">
            <div class = "faqs-title">Dúvidas</div>
            <div class = "faqs-buttons">
                <button type="button" class="submit-button" onClick="newFaq();">Adicionar Dúvida</button>
            </div>
        </div>
        <c:choose>
        <c:when test="${not empty faqList}">
            <c:forEach var="faqList" items="${faqList}">
                <div class="faq-box">
                    <div class="faq-box-header">                        
                        <div class="faq-box-title"> ${faqList.question} </div>
                        
                        <div class="faq-buttons dropdown pull-right">
                            <i class="fa fa-ellipsis-v" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                            </i>

                            <div class="dropdown-menu item-buttons-box" aria-labelledby="dropdownMenuLink">

                              <div onClick="location.href='editFaq.html?token=${faqList.token}'"><i class="fa fa-edit"  ></i> <a>Editar Dúvida </a>  </div>   
                              <div data-toggle="modal" data-target="#deleteFaqDialog" data-index="${faqList.idFaq}"><i class="fa fa-trash"></i> <a>Excluir Dúvida </a></div>                        
                            </div>
                        </div>
                    </div>
                            
                    <div class="faq-box-info">
                        ${faqList.answer}
                    </div>    
                            
                </div>     
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="emptyList"> Nenhuma dúvida registrada!</div>
        </c:otherwise> 
        </c:choose>   
    </div>    
    
    <div id="deleteFaqDialog" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title">Deseja realmente excluir a Dúvida?</h5>
                    <input type="hidden" id="index"/>                             
                </div>                                                                    
                <div class="modal-footer">
                    <button type="button" class="btn close-button" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn submit-button" data-dismiss="modal" onclick="deleteFaq();">Excluir</button>
                </div>
            </div>
        </div>
   </div>  
                                                        
    <div id="modalMessageDialog" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title">Message</h5>
                    <input type="hidden" id="index"/>                             
                </div>                                                                    
                <div class="modal-footer">
                    <button type="button" class="btn close-button" data-dismiss="modal">Fechar</button>                                        
                </div>
           </div>
        </div>
  </div> 
  
  <div class = "hotel-result-footer" style="height: 35px" >
        <div class = "hotel-result-buttons">             
            <div  class="fa fa-caret-left caret" onclick="backward()"></div>
            <div  class="count"> ( ${faqs.page} de ${faqs.pages} )</div> 
            <div  class="fa fa-caret-right caret"  onclick="forward()"></div>                  
            <div  class="total"> ${faqs.total} registros </div> 
        </div>              
                  
    </div>        
</div>   
    
                    
                    
<% if(  request.getAttribute("modalMessage") != null ) { %>
<script>

    $("#modalMessageDialog .modal-title").text( "${modalMessage}") ;

    $("#modalMessageDialog").modal();  
</script>
<%}%>            
                    
<script>
            
    $('#deleteFaqDialog').on('show.bs.modal', function(e) 
    {
        //get data-id attribute of the clicked element
        var index = $(e.relatedTarget).data('index');        
        $("#deleteFaqDialog .modal-header #index").val( index );
    
    }); 
            
                                                                                        
</script>   
        