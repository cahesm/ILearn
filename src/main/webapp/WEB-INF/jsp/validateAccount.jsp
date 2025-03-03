<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Spring Tiles Contact Form</title>

  
<style>
    

html,
body {
  height: 100%;
}

body {
  display: flex;
  flex-direction: column;
}




.errorMsg{
    font-size: 12px;
    color: red;    
}

.sucessMsg{
    font-size: 12px;
    color: green;    
}



.modal-header{
    display: block !important;
}



</style>        
</head>

<script>
    
    
    let onFileSelected = function ()
    {
        //$(".fa fa-plus").prop('disabled',true);

        //$("#uploadMessageDialog").modal();

        var spinner = $('.loader');

        var file = document.getElementById('fileInput').files[0];

        var fd = new FormData();
        fd.append("multipartFile", file);

        spinner.show();

        //var dt = {multipartFile: file};

        // Ajax call for file uploaling
        var ajaxReq = $.ajax(
        {
          url : 'uploadUserDocument.html',
          type : 'POST',
          data: fd,
          dataType: 'json',
          cache : false,
          contentType : false,
          processData : false,
          xhr: function()
          {
            //Get XmlHttpRequest object
             var xhr = $.ajaxSettings.xhr() ;

            //Set onprogress event handler 
             xhr.upload.onprogress = function(event)
             {
                    var perc = Math.round((event.loaded / event.total) * 100);
                    $('#progressBar').text(perc + '%');
                    $('#progressBar').css('width',perc + '%');
             };
             return xhr ;
            },
            beforeSend: function( xhr ) 
            {
                    //Reset alert message and progress bar
                    $('#alertMsg').text('');
                    $('#progressBar').text('');
                    $('#progressBar').css('width','0%');
            }
        });

        // Called on success of file upload
        ajaxReq.done(function(media) 
        {
          loadDocument( media );
          $('#alertMsg').attr('class', 'sucessMsg');
          $('#alertMsg').text("Upload realizado com sucesso");
          $('#fileInput').val('');
           spinner.hide();
          //$('.fa fa-plus').prop('disabled',false);
        });

        // Called on failure of file upload
        ajaxReq.fail(function(jqXHR) {
          $('#alertMsg').attr('class', 'errorMsg'); 
          $('#alertMsg').text('('+jqXHR.status+
                    ' - '+jqXHR.statusText+')');

           spinner.hide();
        });
    };
        
    let loadDocument = function ( media ) 
    {

        let query = "a#validationDocLink";
        let queryBt = "#submitDocBt";

        //$(query).attr("href", "javascript:download('${pageContext.request.contextPath}/documents/base/users/"+media.name+"', '"+media.alias+"');");
        $(query).attr("href", "javascript:download('${pageContext.request.contextPath}/documents/temp/users/"+media.name+"', '"+media.alias+"');");
        $(query).attr("name", media.name );
        $(query).attr("alias", media.alias );
        $(query).removeClass("isDisabled");
        $(queryBt).prop('disabled',false);
        $(query).text( media.alias );

    };
        
    let submitDocument = function()
    {
        let query = "a#validationDocLink";
        let mediaName = $(query).attr("name");
        let mediaAlias = $(query).attr("alias");

        if ( mediaName && mediaAlias )
        {                                                    
            redirectPost( "submitUserDocument.html",{name:mediaName, alias:mediaAlias });
        }
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
    
</script>

<div class="center-box box-column" style="padding-top: 20px; padding-bottom: 20px; "> 
    <div class="account-box" >
        <div class = "account-title">Validação de Conta</div>

        <div class="account-content">
            <div class="p-3 text-center">
                <img src="resources/img/selfyID.png"></img>
            </div>    
            <div class="infoBlockText">  
                <input class="form-control" type="file" name="file" id="fileInput" style="display:none;" onchange="onFileSelected();">    
                <p class="infoBlockContent"> Para que possamos validar seu usuário solicitamos que você tire uma selfie mostrando o documento de identidade ou CNH, conforme a ilustração acima. </p>

                <div id="docsListContainer" class="table-responsive text-center" style="display:block">

                    <div class = "account-documents-heading">
                        <div class = "account-documents-link" >
                         <c:choose>
                            <c:when test="${not empty user.validationDoc}">
                                <a id="validationDocLink" href="javascript:download('${pageContext.request.contextPath}/documents/base/users/${user.validationDoc.name}', '${user.validationDoc.alias}');" > ${user.validationDoc.alias} </a>
                            </c:when>
                            <c:otherwise>
                                <a id="validationDocLink" class="isDisabled" href="#"> Nenhum arquivo selecionado! </a>
                            </c:otherwise>    
                        </c:choose>
                        </div>
                            
                        <div id="alertMsg" class="errorMsg"></div> 

                        <c:if test="${not empty user.validationDoc && user.validationDoc.status eq 3 }">
                            <div id="infoMsg" class="errorMsg"> Reprovado: ${user.comment} </div>
                        </c:if>

                        <c:if test="${not empty user.validationDoc && user.validationDoc.status eq 1 }">
                            <div id="infoMsg" class="errorMsg"> Seu documento está sob avaliação, em breve lhe daremos um retorno! </div>
                        </c:if>

                        <c:if test="${user.validationStatus eq 1}">
                            <div id="infoMsg" class="sucessMsg"> Aprovado </div>        
                        </c:if>

                    </div>
                    

                </div>
            </div>    
        </div>    
    </div>
    <div class="account-box">
        <div class = "buttonGroup">
            <center>
                <c:if test="${user.validationStatus eq 0 || user.validationStatus eq 2 }">
                 <button  type="button" class="btn submit-button" data-dismiss="modal" onclick="document.getElementById('fileInput').click();"> Selecionar</button>
                 <button  disabled id="submitDocBt" type="button" class="btn submit-button" data-dismiss="modal" onclick="submitDocument();"> Enviar</button>
                 <button type="button" class="btn close-button" onClick="location.href = 'account.html'">Fechar</button>
                </c:if> 
            </center>     
        </div>
    </div>    
</div>    
             
<div class="loader"></div>
