<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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

.tab-pane{ font-size: 14px; padding-top: 10px; padding-bottom: 10px;}
.nav-tabs{
    border: 0;
}


</style>

<script>
    let onFileSelected = function (index)
        {
            //$(".fa fa-plus").prop('disabled',true);
            var spinner = $('.loader');
                        
            var file = document.getElementById('fileInput'+index).files[0];
            var idUnit = document.getElementById('idUnit'+index).value;
            
            var fd = new FormData();
            fd.append("multipartFile", file);
            fd.append("idUnit", idUnit);
            
            spinner.show();
            
            //var dt = {multipartFile: file};
            
            // Ajax call for file uploaling
            var ajaxReq = $.ajax(
            {
              url : 'uploadUnitDocument.html',
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
                        $('#alertMsg'+index).text('');
                        $('#progressBar').text('');
                        $('#progressBar').css('width','0%');
                }
            });

            // Called on success of file upload
            ajaxReq.done(function(media) 
            {
              loadDocument( media, index );
              $('#alertMsg'+index).text("Upload realizado com sucesso");
              $('#fileInput').val('');
               spinner.hide();
              //$('.fa fa-plus').prop('disabled',false);
            });

            // Called on failure of file upload
            ajaxReq.fail(function(jqXHR) {
              $('#alertMsg'+index).text('('+jqXHR.status+
                        ' - '+jqXHR.statusText+')');
              $('.fa fa-plus').prop('disabled',false);
               spinner.hide();
            });
        };
        
        let loadDocument = function ( media, index ) {
            
            let query = "a#validationDocLink"+index;
            
            $(query).attr("href", "javascript:download('${pageContext.request.contextPath}/documents/base/units/"+media.name+"', '"+media.alias+"');");
            $(query).removeClass("isDisabled");
            $(query).text( media.alias );
                                    
        };
        
        
        let onVoucherSelected = function (index)
        {
            $(".fa fa-plus").prop('disabled',true);
            
            var spinner = $('.loader');
                        
            var file = document.getElementById('voucherInput'+index).files[0];
            var idReservation = document.getElementById('reservations'+index+".idReservation").value;
            
            var fd = new FormData();
            fd.append("multipartFile", file);
            fd.append("idReservation", idReservation);
            
            spinner.show();
            
            //var dt = {multipartFile: file};
            
            // Ajax call for file uploaling
            var ajaxReq = $.ajax(
            {
              url : 'uploadReservationVoucher.html',
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
              loadVoucher( media, index );
              $('#alertMsg').text("Upload realizado com sucesso");
              $('#fileInput').val('');
              $('.fa fa-plus').prop('disabled',false);
              spinner.hide();
            });

            // Called on failure of file upload
            ajaxReq.fail(function(jqXHR) {
              $('#alertMsg').text('('+jqXHR.status+
                        ' - '+jqXHR.statusText+')');
              $('.fa fa-plus').prop('disabled',false);
              spinner.hide();
            });
        };
        
        let loadVoucher = function ( media, index ) {
            
            let query = "a#voucherDocLink"+index;
            
            $(query).attr("href", "javascript:download('${pageContext.request.contextPath}/documents/base/vouchers/"+media.name+"', '"+media.alias+"');");
            $(query).removeClass("isDisabled");
            $(query).text( media.alias );
                                    
        };
        
        
        
        let approveReservation = function ( el, index )
        {
            var spinner = $('.loader');
            
            $( el ).prop('disabled',true);
                                                           
            var idReservation = document.getElementById('reservations'+index+".idReservation").value;
            var statusCol = document.getElementById('reservations'+index+".status");
            var btApprove = document.getElementById('reservations'+index+".btApprove");
            var btReprove = document.getElementById('reservations'+index+".btReprove");
           
            var fd = new FormData();            
            fd.append("idReservation", idReservation);
            
            spinner.show();
           
            // Ajax call for file uploaling
            var ajaxReq = $.ajax(
            {
              url : 'approveReservation.html',
              type : 'POST',
              data: fd,
              dataType: 'json',
              cache : false,
              contentType : false,
              processData : false
              
            });

            // Called on success of file upload
            ajaxReq.done(function(reservation) 
            {
                if ( reservation.status === 1 )
                {
                    statusCol.innerHTML = "Aguardando Pagamento";
                }
                
                btApprove.parentNode.removeChild(btApprove);
                btReprove.parentNode.removeChild(btReprove);
             
              $(el).prop('disabled',false);
              
              spinner.hide();
            });

            // Called on failure of file upload
            ajaxReq.fail(function(jqXHR) {
              $('#alertMsg').text('('+jqXHR.status+
                        ' - '+jqXHR.statusText+')');
              $(el).prop('disabled',false);
              spinner.hide();
            });
        }
        
        let reproveReservation = function()
        {
            var spinner = $('.loader');
            
            var index =  $("#addCommentDialog .modal-body #index").val();
            var idReservation = document.getElementById('reservations'+index+".idReservation").value;
            var statusCol = document.getElementById('reservations'+index+".status");
            var commentCol = document.getElementById('reservations'+index+".comment");
            var btApprove = document.getElementById('reservations'+index+".btApprove");
            var btReprove = document.getElementById('reservations'+index+".btReprove");
                                                                       
            var comment =  $("#addCommentDialog .modal-body #comment").val();
            
            spinner.show();
                       
            var fd = new FormData();            
            fd.append("idReservation", idReservation);
            fd.append("comment", comment);
           
            // Ajax call for file uploaling
            var ajaxReq = $.ajax(
            {
              url : 'reproveReservation.html',
              type : 'POST',
              data: fd,
              dataType: 'json',
              cache : false,
              contentType : false,
              processData : false
            });
              
            // Called on success of file upload
            ajaxReq.done(function(reservation) 
            {
                if ( reservation.status === 1 )
                {
                    statusCol.innerHTML = "Aguardando Pagamento";
                }
                else if ( reservation.status === 5 )
                {
                    statusCol.innerHTML = "Reprovado";
                    commentCol.innerHTML = reservation.comment;
                } 
                
                btApprove.parentNode.removeChild(btApprove);
                btReprove.parentNode.removeChild(btReprove);
                
                spinner.hide();
              
            });

            // Called on failure of file upload
            ajaxReq.fail(function(jqXHR) {
              $('#alertMsg').text('('+jqXHR.status+
                        ' - '+jqXHR.statusText+')');
              $(el).prop('disabled',false);
              
               spinner.hide();
            });
        }
        
        
        function deleteUnit()
        {
            var idUnit =  $("#deleteUnitDialog .modal-header #index").val();
            
            redirectPost("deleteUnit.html", { id: idUnit });
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
        
        function download(dataurl, filename) {
            
        var a = document.createElement("a");
        a.href = dataurl;
        a.setAttribute("download", filename);
        a.click();
        }
        
        function newUnit()
        {
             document.location.href = "addUnit.html";
        }
        
</script>


<div class="center-box box-column" style="padding-top: 20px;padding-bottom: 20px;"> 
    <div class="units-box" >
        <div class = "units-header">
            <div class = "units-title">Minhas Unidades</div>
            <div class = "units-buttons">
                <button type="button" class="btn submit-button" onClick="newUnit();">Criar Unidade</button>
            </div>
        </div> 
        <c:choose>
        <c:when test="${not empty unitList}">
            <c:forEach var="unitList" items="${unitList}" varStatus="status">
                <div class="unit-box">
                    <div class="unit-box-header"> 
                        <div class="unit-box-cod">  ${unitList.cod} </div>
                        <div class="unit-box-title"> ${unitList.hotel.name} </div>
                        <div class="unit-buttons dropdown pull-right">
                            <i class="fa fa-ellipsis-v" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                            </i>

                            <div class="dropdown-menu item-buttons-box" aria-labelledby="dropdownMenuLink" style="left:-150px !important;">
                              <div onClick="location.href='showUnit.html?c=${Base64.getEncoder().encodeToString(unitList.cod.getBytes())}>&back=unit.html'"><i class="fa fa-eye"></i> <a>Mostrar Unidade</a> </div>                                                                                                 
                              <div onClick="location.href='editUnit.html?token=${unitList.token}'"><i class="fa fa-edit"  ></i> <a>Editar Unidade </a>  </div>                                                     
                              <div data-toggle="modal" data-target="#deleteUnitDialog" data-index="${unitList.idUnit}"><i class="fa fa-trash"></i> <a>Excluir Unidade </a></div>                        
                              <div onClick="location.href='unitReservation.html?token=${unitList.token}'"><i class="fa fa-calendar"  ></i> <a>Reservas</a>  </div>   
                            </div>
                        </div>
                    </div>
                    <div class="unit-info-box">
                        <img class="d-flex align-self-start"        
                        <c:choose>
                        <c:when test="${empty unitList.medias}">
                            src="images/noImage.png"
                        </c:when>    
                        <c:otherwise>
                           src="${pageContext.request.contextPath}/images/base/hotels/${unitList.hotel.medias[0].name}"
                        </c:otherwise>
                        </c:choose>        

                         alt="Generic placeholder image"/>
                        
                        <div class="unit-info-content">
                            <div class="unit-short-info"> 
                                <div><i class="fa fa-square"></i>${unitList.room} quartos</div>
                                <div><i class="fa fa-hotel"></i>${unitList.bedRoom} camas</div>
                                <div><i class="fa fa-bath"></i>${unitList.bathRoom} banheiros</div>                                                        
                                <div><i class="fa fa-users"></i>${unitList.person} pessoas</div>      
                            </div>
                            
                            <div class="unit-info-address">
                                <div><i class="fa fa-arrows"></i>${unitList.hotel.address.number}, ${unitList.hotel.address.address}, ${unitList.hotel.address.city} - ${unitList.hotel.address.country}  </div>                                                        
                            </div>
                            
                            <c:if test="${ not empty unitList.hotel.site}">
                            <div class="unit-info-site">
                                <div><i class="fa fa-globe"></i><a href="${unitList.hotel.site}" target="_blank">${unitList.hotel.site}</a>  </div>                                                                                                                                                                        
                            </div>                                                       
                            </c:if>  
                            
                            <c:if test="${unitList.validationStatus eq 0}">
                            <div class="unit-info-status">                                                                                        
                                <p class="text-danger">   
                                    <strong>Não validado!</strong>
                                </p>                                      
                            </div>
                            </c:if>
                            
                        </div>    
                    </div> 
                    
                    <div id="addCommentDialog" class="modal fade" role="dialog">
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
                                    <button type="button" class="btn submit-button" data-dismiss="modal" onclick="reproveReservation();">Enviar</button>
                                </div>
                            </div>
                        </div>                                
                    </div>                   
                            
                    <div id="deleteUnitDialog" class="modal fade" role="dialog">
                        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                          <div class="modal-content">

                            <div class="modal-header">
                                <h5 class="modal-title">Deseja realmente excluir unidade?</h5>
                                <input type="hidden" id="index"/>                             
                            </div>                                                                    
                            <div class="modal-footer">
                                <button type="button" class="btn close-button" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn submit-button" data-dismiss="modal" onclick="deleteUnit();">Excluir</button>
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
                    
                    <div class="unit-tabs">
                        <ul class="nav nav-tabs " role="tablist">
                            <li class="nav-item">
                              <a class="nav-link active" href="#reservations-${status.index}" role="tab" aria-controls="reservations-${status.index}" aria-selected="true">Reservas Ativas</a>
                            </li>                                                         
                            <li class="nav-item">
                              <a class="nav-link" href="#validation-${status.index}" role="tab" aria-controls="validation-${status.index}" aria-selected="false">Validação</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="reservations-${status.index}" role="tabpanel" aria-labelledby="reservations-${status.index}-tab">                                                              
                                <c:choose>
                                <c:when test="${not empty unitList.reservations}">
                                    <c:forEach items="${unitList.reservations}" var="reservations" varStatus="status2">   
                                        <input type="hidden" id="reservations${status.index}_${status2.index}.idReservation" value="${reservations.idReservation}"/>
                                        <input class="form-control" type="file" name="file" id="voucherInput${status.index}_${status2.index}" style="display:none;" onchange="onVoucherSelected('${status.index}_${status2.index}');">
                                        
                                        <div class="unit-reservation-item-box">                                            
                                            <div class="unit-reservation-item-top">
                                                <div class = "unit-reservation-item-cod">
                                                    <a href="showReservation.html?c=${Base64.getEncoder().encodeToString(reservations.cod.getBytes())}>&back=unit.html">${reservations.cod}</a>                 
                                                </div>
                                                <div class = "unit-reservation-item-status">
                                                    <c:choose>
                                                    <c:when test = "${reservations.status eq 0}">
                                                      <p class="text-danger">Aguardando Aprovação</p>                                                                            
                                                     </c:when>
                                                     <c:when test = "${reservations.status eq 1}">
                                                      Aguardando pagamento   
                                                     </c:when>
                                                     <c:when test = "${reservations.status eq 2}">
                                                      <p class="text-danger">Aguardando Voucher</p>   
                                                     </c:when>
                                                     <c:when test = "${reservations.status eq 3}">
                                                      <p class="text-success">Completada</p> 
                                                     </c:when> 
                                                    <c:otherwise>
                                                    <p class="text-danger">Cancelada</p>                                                                                  
                                                    </c:otherwise>
                                                    </c:choose>                           
                                                </div>
                                                <div class = "item-buttons">
                                                    <i class="fa fa-chevron-down float-right" data-toggle="collapse" data-target="#reservation${status.index}_${status2.index}"></i> 
                                                </div> 
                                            </div>
                                            <div id="reservation${status.index}_${status2.index}" class="unit-reservation-item-content panel-collapse collapse">
                                                <table>

                                                    <tr>
                                                        <td>Checkin</td>
                                                        <td>
                                                            <fmt:formatDate value="${reservations.startDate}" pattern="dd/MM/yyyy"/>
                                                        </td>     
                                                    </tr>    
                                                    <tr>
                                                        <td>Checkout</td>
                                                        <td>
                                                            <fmt:formatDate value="${reservations.endDate}" pattern="dd/MM/yyyy"/>
                                                        </td>     
                                                    </tr>    
                                                    <tr>
                                                        <td>Voucher</td>
                                                        <td> 
                                                             <c:choose>
                                                            <c:when test="${not empty reservations.voucher}">
                                                               <a id="voucherDocLink${status.index}_${status2.index}" href="javascript:download('${pageContext.request.contextPath}/documents/base/vouchers/${reservations.voucher.name}', '${reservations.voucher.alias}');" > ${reservations.voucher.alias} </a>
                                                             </c:when>
                                                             <c:otherwise>
                                                               <a id="voucherDocLink${status.index}_${status2.index}" class="isDisabled" href="#"> n/d </a>
                                                             </c:otherwise>  
                                                           </c:choose>   
                                                        </td>   
                                                    </tr>    

                                                    <tr>
                                                        <td>Comentário</td>
                                                        <td id="reservations${status.index}_${status2.index}.comment">
                                                           ${not empty reservations.comment ? reservations.comment : 'n/d'}
                                                        </td>   
                                                    </tr>    
                                                        
                                                </table>
                                                        
                                                <c:if test = "${reservations.status eq 0 || reservations.status eq 2 }">  
                                                        
                                                        <div class="buttonGroup">
                                                            <center>                                                                                                    
                                                            <c:choose>
                                                            <c:when test = "${reservations.status eq 0}">                                                                                  
                                                                <button type="button" id="reservations${status.index}_${status2.index}.btApprove" class="btn submit-button" onclick=approveReservation(this,'${status.index}_${status2.index}')>Aprovar</button>
                                                                <button type="button" id="reservations${status.index}_${status2.index}.btReprove" class="btn close-button" data-toggle="modal" data-target="#addCommentDialog" data-index="${status.index}_${status2.index}">Reprovar</button>
                                                            </c:when>
                                                            <c:when test = "${reservations.status eq 2}">                                                                                  
                                                                <button type="button" id="reservations${status.index}_${status2.index}.btVoucher" class="btn submit-button" onclick="document.getElementById('voucherInput${status.index}_${status2.index}').click();">Selecionar Voucher </button>
                                                            </c:when>                                                                                        
                                                            </c:choose>
                                                            </center>    
                                                        </div>     
                                                           
                                                    </c:if>        
                                            </div>
                                        </div>
                                    </c:forEach>                                                                    
                                </c:when>
                                <c:otherwise>
                                    <span id="noItemsLabel"> Nenhuma reserva ativa!</span>
                                </c:otherwise> 
                                </c:choose>    
                            </div>
                            <div class="tab-pane" id="validation-${status.index}" role="tabpanel" aria-labelledby="validation-${status.index}-tab">                                                            
                                <input id="idUnit${status.index}" type="hidden"  value="${unitList.idUnit}" >
                                <input class="form-control" type="file" name="file" id="fileInput${status.index}" style="display:none;" onchange="onFileSelected('${status.index}');">
                                <div class="unit-validation-box">                                                                        
                                    
                                    <div class = "unit-validation-doc-heading">
                                        <div class="unit-validation-info"> ${unitList.validationStatus eq 0 ? 'Selecione o Contrato para a validação da unidade' : 'Contrato'} </div>                                    
                                        <div class = "unit-validation-doc-link" >
                                            <c:choose>
                                               <c:when test="${not empty unitList.documents}">
                                                   <a id="validationDocLink${status.index}" href="javascript:download('${pageContext.request.contextPath}/documents/base/units/${unitList.documents[0].name}', '${unitList.documents[0].alias}');" > ${unitList.documents[0].alias} </a>
                                               </c:when>
                                               <c:otherwise>
                                                   <a id="validationDocLink${status.index}" class="isDisabled" href="#"> Nenhum arquivo selecionado! </a>
                                               </c:otherwise>    
                                           </c:choose>
                                        </div>
                                        <c:if test="${unitList.validationStatus eq 0}">
                                            <c:choose>
                                            <c:when test="${not empty unitList.documents && unitList.documents[0].status eq 3 }">
                                                <div id="alertMsg${status.index}" class="unit-validation-doc-status reproved"> Reprovado: ${unitList.documents[0].comment} </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div id="alertMsg${status.index}" class="unit-validation-doc-status"></div>
                                            </c:otherwise>    
                                            </c:choose>                                                       
                                        </c:if>

                                        <c:if test="${unitList.validationStatus eq 1}">
                                            <div id="alertMsg${status.index}" class="unit-validation-doc-status"> Aprovado </div>        
                                        </c:if>

                                    </div>
                                    <div class = "unit-validation-doc-footer">
                                        <c:if test="${unitList.validationStatus eq 0}">
                                        <div class="buttonGroup">
                                            <center>   
                                                <button  type="button" class="btn submit-button" data-dismiss="modal" onclick="document.getElementById('fileInput${status.index}').click();"> ${documents.alias}Selecionar</button>
                                            </center>    
                                        </div>   
                                        </c:if> 
                                    </div>                                   
                                </div>                                                                    
                            </div>      
                        </div>
                    </div>    
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="emptyList"> Nenhuma unidade registrada!</div>
        </c:otherwise> 
        </c:choose>    
     </div>
    
</div>

<div class="loader"></div>
        
<% if(  request.getAttribute("modalMessage") != null ) { %>
<script>

    $("#modalMessageDialog .modal-title").text( "${modalMessage}") ;

    $("#modalMessageDialog").modal();  
</script>
<%}%>
        
       
<script>
                                                                              
    $('.nav a').on('click', function (e) {
        e.preventDefault()
        $(this).tab('show')
    });
    
    $('#addCommentDialog').on('show.bs.modal', function(e) {

        //get data-id attribute of the clicked element
        var index = $(e.relatedTarget).data('index');        
        $("#addCommentDialog .modal-body #index").val( index );

    
});

    $('#deleteUnitDialog').on('show.bs.modal', function(e) {

        //get data-id attribute of the clicked element
        var index = $(e.relatedTarget).data('index');        
        $("#deleteUnitDialog .modal-header #index").val( index );

    
});
    
$('.item-buttons i').click(function() { 
    
            $(this).toggleClass('fa fa-chevron-down fa fa-chevron-up'); 
        });    
   
   
</script>
  
  


