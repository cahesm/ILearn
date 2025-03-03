<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>

<style>
    
@media only screen and (min-width: 36.1em)
{    
    .item-heading
    {
        text-align: center !important;
    }
    
}

@media only screen and (max-width: 36em)
{
    .media { display:block !important;;}
    
    .media img{width: 100% !important; height:230px !important; }
            
}



@media only screen and (max-width: 24em)
{
    .media { display:block !important;;}
    
    .media img{width: 100% !important; height:200px !important; }
    
}


.documents-link {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100px;
  
}

.documents-title { margin-bottom: 0px !important;}
.documents-heading { border: 2px dashed gray;}
.documents-footer { padding: 5px; border: 1px; }

.property-item{ padding: 3px 5px 3px 10px; display: flex; width: 100%; }
.property-item-label{ text-align: left; font-weight: bold; font-size: 13px; color: #4765AB; min-width: 100px; display: flex; }
.property-item-value{ text-align: left; font-size: 13px; width: 100%; }



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

.tab-pane{ font-size: 14px;}

.text-success{ margin-bottom: 0px !important; }
.text-danger{ margin-bottom: 0px !important; }


.btn{margin-right: 5px;}

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
        }
        
        let loadDocument = function ( media, index ) {
            
            let query = "a#validationDocLink"+index;
            
            $(query).attr("href", "javascript:download('${pageContext.request.contextPath}/documents/base/units/"+media.name+"', '"+media.alias+"');");
            $(query).removeClass("isDisabled");
            $(query).text( media.alias );
                                    
        }
        
        
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
        }
        
        let loadVoucher = function ( media, index ) {
            
            let query = "a#voucherDocLink"+index;
            
            $(query).attr("href", "javascript:download('${pageContext.request.contextPath}/documents/base/vouchers/"+media.name+"', '"+media.alias+"');");
            $(query).removeClass("isDisabled");
            $(query).text( media.alias );
                                    
        }
        
        
        
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
        }
        
        function download(dataurl, filename) {
            
        var a = document.createElement("a");
        a.href = dataurl;
        a.setAttribute("download", filename);
        a.click();
        }
        
</script>

<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">   
                                   
<div class = "panel-group">
            <div class = "panel panel-default">
                <div class = "panel-heading">
                    <h4 class = "panel-title">
                        <a data-toggle = "collapse" href = "#unitList">Minhas Unidades</a>                         
                    </h4>
                    <div class="panel-buttons">
                        <a href="addUnit.html">
                        <i class="fa fa-plus"></i>
                        </a>
                    </div>    
                </div>
                <div id = "unitList" class = "panel-collapse expand">
                    <div class = "panel-body">    
                        <c:choose>
                        <c:when test="${not empty unitList}">
                        <c:forEach var="unitList" items="${unitList}" varStatus="status">	
                        <section class="search-box">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-12 listing-block">
                                        <div class="item-heading">                                             
                                             <div class = "item-cod">
                                                 ${unitList.cod}
                                             </div>
                                             <div class = "item-title">
                                                 ${unitList.hotel.name}
                                             </div>
                                             <div class="item-buttons dropdown pull-right show">
                                                <i class="fa fa-ellipsis-v" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                
                                                </i>

                                                <div class="dropdown-menu item-buttons-box" aria-labelledby="dropdownMenuLink">
                                                  <div onClick="location.href='showUnit.html?c=${Base64.getEncoder().encodeToString(unitList.cod.getBytes())}>&back=unit.html'"><i class="fa fa-eye"></i> <a>Mostrar Unidade</a> </div>                                                                                                 
                                                  <div onClick="location.href='editUnit.html?token=${unitList.token}'"><i class="fa fa-edit"  ></i> <a>Editar Unidade </a>  </div>                                                     
                                                  <div data-toggle="modal" data-target="#deleteUnitDialog" data-index="${unitList.idUnit}"><i class="fa fa-trash"></i> <a>Excluir Unidade </a></div>                        
                                                  <div onClick="location.href='unitReservation.html?token=${unitList.token}'"><i class="fa fa-calendar"  ></i> <a>Reservas</a>  </div>   
                                                </div>
                                              </div>
                                                                                                                                                                                                                                                                                                                                                                        
                                        </div>
                                        <div class="item">     
                                            
                                            <div class="media">                                                                                                
                                                <img class="d-flex align-self-start"        
                                                <c:choose>
                                                <c:when test="${empty unitList.medias}">
                                                    src="images/noImage.png"
                                                </c:when>    
                                                <c:otherwise>
                                                   src="${pageContext.request.contextPath}/images/base/hotels/${unitList.hotel.medias[0].name}"
                                                </c:otherwise>
                                                </c:choose>        
                                                    
                                                 alt="Generic placeholder image">
                                                <div class="media-body">
                                                    <div class="price" ><small>${unitList.hotel.address.country}</small></div>                                                    
                                                    <div class="address">
                                                        <span><i class="fa fa-arrows"></i>${unitList.hotel.address.number}, ${unitList.hotel.address.address}, ${unitList.hotel.address.city}  </span>                                                        
                                                    </div>
                                                     <div class="stats">
                                                        <div><i class="fa fa-square"></i>${unitList.room} quartos</div>
                                                        <div><i class="fa fa-hotel"></i>${unitList.bedRoom} camas</div>
                                                        <div><i class="fa fa-bath"></i>${unitList.bathRoom} banheiros</div>                                                        
                                                        <div><i class="fa fa-users"></i>${unitList.person} pessoas</div>                                                        
                                                    </div>
                                                    <c:if test="${ not empty unitList.hotel.site}">
                                                    <div class="site">
                                                        <span><i class="fa fa-globe"></i><a href="${unitList.hotel.site}" target="_blank">${unitList.hotel.site}</a>  </span>                                                                                                                                                                        
                                                    </div>                                                       
                                                    </c:if>                                                    
                                                    <div class="status">                                                        
                                                       <c:if test="${unitList.validationStatus eq 0}">
                                                         <p class="text-danger">   
                                                        <strong>Não validado!</strong>
                                                        </p>
                                                        </c:if>     
                                                    </div>
                                                    
                                                </div>
                                            </div>
                                                                                        
                                            <div class="tabs-body">
                                                <div class="card text-center">
                                                    <div class="card-header">
                                                        <ul class="nav nav-tabs card-header-tabs" role="tablist">
                                                          <li class="nav-item">
                                                            <a class="nav-link active" href="#reservations-${status.index}" role="tab" aria-controls="reservations-${status.index}" aria-selected="true">Reservas Ativas</a>
                                                          </li>                                                         
                                                          <li class="nav-item">
                                                            <a class="nav-link" href="#validation-${status.index}" role="tab" aria-controls="validation-${status.index}" aria-selected="false">Validação</a>
                                                          </li>
                                                        </ul>
                                                      </div>
                                                      <div class="card-body p-2">                                                        
                                                         <div class="tab-content">
                                                          <div class="tab-pane active" id="reservations-${status.index}" role="tabpanel" aria-labelledby="reservations-${status.index}-tab">                                                              
                                                              <c:choose>
                                                                <c:when test="${not empty unitList.reservations}">
                                                                                                                                                                                                               
                                                                    <div id="reservationListContainer" class="table-responsive" style="display:block">
                                                                        
                                                                        <c:forEach items="${unitList.reservations}" var="reservations" varStatus="status2">
                                                                            <div class="colapse-item-heading reservationItem">
                                                                                <input type="hidden" id="reservations${status.index}_${status2.index}.idReservation" value="${reservations.idReservation}"/>
                                                                                <input class="form-control" type="file" name="file" id="voucherInput${status.index}_${status2.index}" style="display:none;" onchange="onVoucherSelected('${status.index}_${status2.index}');">
                                                                                <div class="colapse-item-cod"><a href="showReservation.html?c=${Base64.getEncoder().encodeToString(reservations.cod.getBytes())}>&back=unit.html">${reservations.cod}</a></div>
                                                                                <div class="colapse-item-title" id="reservations${status.index}_${status2.index}.status">
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
                                                                                <div class="colapse-item-buttons"> 
                                                                                    <i class="fa fa-chevron-down float-right" data-toggle="collapse" data-target="#reservation${status.index}_${status2.index}"></i> 
                                                                                </div>
                                                                            </div>  
                                                                            <div id="reservation${status.index}_${status2.index}" class="panel-collapse collapse colapse-item-body">
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
                                                                                     <c:if test = "${reservations.status eq 0 || reservations.status eq 2 }">  
                                                                                         <tr>
                                                                                             <td colspan="2">
                                                                                            <c:choose>
                                                                                           <c:when test = "${reservations.status eq 0}">                                                                                  
                                                                                               <button type="button" id="reservations${status.index}_${status2.index}.btApprove" class="btn btn-primary" onclick=approveReservation(this,'${status.index}_${status2.index}')>Aprovar</button>
                                                                                               <button type="button" id="reservations${status.index}_${status2.index}.btReprove" class="btn btn-secondary" data-toggle="modal" data-target="#addCommentDialog" data-index="${status.index}_${status2.index}">Reprovar</button>
                                                                                           </c:when>
                                                                                           <c:when test = "${reservations.status eq 2}">                                                                                  
                                                                                               <button type="button" id="reservations${status.index}_${status2.index}.btVoucher" class="btn btn-primary" onclick="document.getElementById('voucherInput${status.index}_${status2.index}').click();">Selecionar Voucher </button>
                                                                                           </c:when>                                                                                        
                                                                                           </c:choose>  
                                                                                               </td>
                                                                                        </tr>
                                                                                     </c:if>    
                                                                                        
                                                                                </table>	
                                                                                                                                                                                                                                                                                                                                
                                                                            </div>    
                                                                            
                                                                        </c:forEach>   
                                                                            
                                                                        
                                                                    </div>
                                                                
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span id="noItemsLabel"> Nenhuma reserva ativa!</span>
                                                                </c:otherwise> 
                                                                </c:choose>    
                                                          </div>

                                                          
                                                          <div class="tab-pane" id="validation-${status.index}" role="tabpanel" aria-labelledby="validation-${status.index}-tab">                                                            
                                                                <input id="idUnit${status.index}" type="hidden"  value="${unitList.idUnit}" >
                                                                <input class="form-control" type="file" name="file" id="fileInput${status.index}" style="display:none;" onchange="onFileSelected('${status.index}');">
                                                            
                                                            <p>Selecione o Contrato para a validação da unidade</p>
                                                            
                                                            <div id="docsListContainer" class="table-responsive" style="display:block">
                                                                
                                                                <div class = "documents-heading">
                                                                    <div class = "documents-link" >
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
                                                                        
                                                                        <c:if test="${not empty unitList.documents && unitList.documents[0].status eq 3 }">
                                                                            <div id="alertMsg${status.index}" style="color: red;font-size: 16px;"> Reprovado: ${unitList.documents[0].comment} </div>
                                                                        </c:if>
                                                                                                                                                
                                                                        <!-- Alert -->
                                                                        <div id="alertMsg${status.index}" style="color: green;font-size: 12px;"></div>        
                                                                    </c:if>
                                                                    
                                                                    <c:if test="${unitList.validationStatus eq 1}">
                                                                        <div id="alertMsg${status.index}" style="color: green;font-size: 16px;"> Aprovado </div>        
                                                                    </c:if>
                                                                    
                                                                </div>
                                                                <div class = "documents-footer">
                                                                    <c:if test="${unitList.validationStatus eq 0}">
                                                                     <button  type="button" class="btn btn-primary" data-dismiss="modal" onclick="document.getElementById('fileInput${status.index}').click();"> ${documents.alias}Selecionar</button>
                                                                    </c:if> 
                                                                </div>
                                                                    
                                                            </div>
                                                            
                                                          </div>  
                                                        </div>
                                                      </div>
                                                    
                                                </div>
                                            </div>
                                        </div>                      
                                    </div>
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
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="reproveReservation();">Enviar</button>
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
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="deleteUnit();">Excluir</button>
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
                            <div class="emptyList"> Nenhuma unidade registrada!</div>
                        </c:otherwise> 
                        </c:choose>
                    </div>
                                       
                </div>
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
    
                    
    $('.item-heading i').click(function(e) {
                   e.preventDefault();
                   $(this).children('form').first().submit();
    });
    
    
                                  
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
    
$('.reservationItem i').click(function() { 
    
            $(this).toggleClass('fa fa-chevron-down fa fa-chevron-up'); 
        });    
   
   
  </script>
  
  
  
  
</div>
</div>    

