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

.hd_center_container {
  flex-grow: 1;
}
         
.panel-group{
    padding-bottom: 5px;
}

</style>

<script>
         
                  
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
        
        
         
      </script>

</head>

<body>
<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">   
     <form:form id="faqsForm" method="post" action="searchFaqs.html" modelAttribute="faqs">              
       <form:hidden  id="page" path="page" /> 
       <form:hidden  id="pages" path="pages" /> 
    </form:form>       
    
<div class = "panel-group">
            <div class = "panel panel-default">
                <div class = "panel-heading">
                    <h4 class = "panel-title">
                        <a data-toggle = "collapse" href = "#faqList">Dúvidas</a>                       
                    </h4>
                    <div class="panel-buttons">
                        <a href="addFaq.html">
                        <i class="fa fa-plus"></i>
                        </a>
                    </div>    
                </div>                
                <div id = "faqList" class = "panel-collapse expand">
                    <div class = "panel-body">                         
                        <c:choose>
                        <c:when test="${not empty faqList}">
                        <c:forEach var="faqList" items="${faqList}">
                         
                        <section class="search-box">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-12 listing-block">
                                        <div class="item-heading">                                                                                          
                                             <div class = "item-title">
                                                 ${faqList.question}
                                             </div>
                                             <div class="item-buttons dropdown pull-right">
                                                <i class="fa fa-ellipsis-v" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                
                                                </i>

                                                <div class="dropdown-menu item-buttons-box" aria-labelledby="dropdownMenuLink">
                                                  
                                                  <div onClick="location.href='editFaq.html?token=${faqList.token}'"><i class="fa fa-edit"  ></i> <a>Editar Dúvida </a>  </div>   
                                                  <div data-toggle="modal" data-target="#deleteFaqDialog" data-index="${faqList.idFaq}"><i class="fa fa-trash"></i> <a>Excluir Dúvida </a></div>                        
                                                </div>
                                              </div>
                                                                                                                                                                                                                                                                                                                                                                        
                                        </div>                                                                           
                                        <div id="faq${status.index}" class="item panel-collapse">   
                                            
                                            <div class="faq-text text-justify">   
                                                
                                                ${faqList.answer}
                                                
                                                
                                            </div>
                                                                                                                                                                                      
                                        </div>                 
                                    </div>
                                </div>
                            </div>
                            <div id="deleteFaqDialog" class="modal fade" role="dialog">
                                <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                                  <div class="modal-content">
                                
                                    <div class="modal-header">
                                        <h5 class="modal-title">Deseja realmente excluir a Dúvida?</h5>
                                        <input type="hidden" id="index"/>                             
                                    </div>                                                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="deleteFaq();">Excluir</button>
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
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>                                        
                                    </div>
                                    </div>
                                    </div>
                                
                           </div>                        
                        </section>
                        </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="emptyList"> Nenhuma dúvida registrada!</div>
                        </c:otherwise> 
                        </c:choose>
                    </div>                                      
                </div>
                <div class = "panel-footer" style="height: 35px" >
                    <h4 class = "panel-title">             
                        <i  class="fa fa-caret-right caret"  onclick="forward()"></i>  
                        <i  class="records-count"> ( ${faqs.page} de ${faqs.pages} )</i> 
                        <i  class="fa fa-caret-left caret" onclick="backward()"></i>
                        <i  class="records-total"> ${faqs.total} registros </i> 
                    </h4>              
                  
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
            
           $('#deleteFaqDialog').on('show.bs.modal', function(e) {

        //get data-id attribute of the clicked element
        var index = $(e.relatedTarget).data('index');        
        $("#deleteFaqDialog .modal-header #index").val( index );

    
}); 
            
                   
           $('.item-heading i').click(function(e) {
                   e.preventDefault();
                   $(this).children('form').first().submit();
    });
    
                        
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
        </div>
        </div>            
    </body>
</html>
