<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.List"%>
<%@page import="com.javatpoint.model.Unit"%>
<html>
<head>
<title>Busca</title>      
<link href="<c:url value="/resources/styles/searchCards.css" />" rel="stylesheet">      
<link href="<c:url value="/resources/styles/jquery-ui.css" />" rel="stylesheet">
<script src="<c:url value="/resources/scripts/jquery-ui.js" />"></script>
      
<style>

html,body 
{
  height: 100%;
}

body 
{
  display: flex;
  flex-direction: column;
}


.finalPrice
{
    color: #dc3545;
    font-size: 12px;
}


</style>
      
<!-- Javascript -->
<script>

    var ctx = "${pageContext.request.contextPath}";

    $(function() 
    {

        $( "#hotelSearch" ).autocomplete({
         minLength: 1,
         source: function (request, response) {
          $.ajax({
          type: "POST",
          url:"getHotels.html",
          data: {tagName:request.term},
          success: response,
          dataType: 'json',
          minLength: 1,
          delay: 100
              });
          },

         focus: function( event, ui ) {
            //$( "#project" ).val( ui.item.label );
               return false;
         },
         select: function( event, ui ) {
            //$( "#project" ).val( ui.item.name );
            //$( "#project-id" ).val( ui.item.id );
            $( "#hotelSearch" ).val( ui.item.name );
            $( "#idHotel" ).val( ui.item.id );

            return false;
         }
      })

      .data( "ui-autocomplete" )._renderItem = function( ul, item ) {              
         return $( "<li style='width:100%;'>" )                   
              .append( $( "<div class='searchRow' style='width:100%;'>" ) 
              .append( $( "<div class='searchTerm' style='display:table-cell; width:100px'>" ).text( item.term ) )
              .append( $( "<div class='searchValue' style='display:table-cell;'>" ).text( item.name ) ) )                        
              .appendTo( ul );                       
      };

      $("#unitForm").find('.numberField').each(function() 
      { 
          this.oninput = function() { this.value = this.value.replace(/[^0-9,]/g, '').replace(/(\,.*)\,/g, '$1'); }; 
      });

      $("#unitForm").find('.intField').each(function() 
      { 
          this.oninput = function() { this.value = this.value.replace(/[^\d]/,''); }; 
      });

      showDispList();
      showCancelOptionsList();
      showUploadsList();
    });

    let showDispList = function ()
    {
        let size = document.getElementById('dispList').getElementsByTagName('tbody')[0].getElementsByTagName('tr').length;

        let showList = size > 0;

        //document.getElementById('dispListContainer').style.display = showList ? 'block' : 'none';
        document.getElementById('noDispsLabel').style.display = !showList ? 'block' : 'none';

    };

    let showCancelOptionsList = function ()
    {
       let size = document.getElementById('cancelOptionsList').getElementsByTagName('tbody')[0].getElementsByTagName('tr').length;

       let showList = size > 0;

       //document.getElementById('cancelOptionsListContainer').style.display = showList ? 'block' : 'none';
       document.getElementById('noCancelOptionsLabel').style.display = !showList ? 'block' : 'none';


    };

    let createInput = function (listName, rowIndex, field) 
    {
        let parts = field.split(":");
        let fieldName = parts[0];
        let fieldType = parts.length > 1 ? parts[1] : "text";

        let inputType = fieldType === "int" || fieldType === "double" ? "text" : fieldType; 

        let input = document.createElement('input');
        input.id = listName + rowIndex + '.' + fieldName;
        input.type = inputType;
        input.setAttribute('name', listName + '[' + rowIndex + '].' + fieldName);

        if ( fieldType === "int" )
        {
            input.oninput = function() { this.value = this.value.replace(/[^\d]/,''); };
        }
        else if ( fieldType === "double" )
        {
            input.oninput = function() { this.value = this.value.replace(/[^0-9,]/g, '').replace(/(\,.*)\,/g, '$1'); }; 
        }    

        return input;
    };

   let addDisponibility = function () 
   {

        let fields = ['nights:text','startDate:date', 'endDate:date', 'price:text'];         
        let listName = 'disponibilities';
        let table = document.getElementById('dispList');
        let tbody = table.getElementsByTagName('tbody')[0];


        let rowIndex = tbody.getElementsByTagName('tr').length;

        let tr = document.createElement('tr');

        fields.forEach((field, index ) => 
        {
           let td = document.createElement('td');
           let input = createInput(listName, rowIndex, field);            
           td.appendChild(input);

            if ( index === 3 )
            {
                input.onchange = function(){ calculateFinalPrice( rowIndex ); }; 

                let finalPrice = document.createElement('div');
                finalPrice.id = "disponibilities"+rowIndex+".finalPrice";
                finalPrice.className = "finalPrice";
                finalPrice.innerHTML = "(Valor + Taxas) = ";
                td.appendChild(finalPrice);
            }

            tr.appendChild(td);
        });

        let td = document.createElement('td');
        td.className = "middle";
        td.innerHTML = "<i class='fa fa-close' onclick='removeDisponibility(this)'></i>";
        tr.appendChild(td);

        tbody.appendChild(tr);  
        showDispList();
    }

    let removeDisponibility = function ( el ) {

        let tr = el.closest("tr");
        let tbody = tr.closest("tbody");            
        //let table = $( tr ).parent("table");

        tbody.removeChild( tr );

        showDispList();

        let rowIndex = 0;

        $(tbody).find('tr').each(function() 
        {

            let cols = this.cells;

            let fields = ['nights','startDate', 'endDate', 'price']; 
            let listName = 'disponibilities';

            for (var x = 0;x < cols.length; x++)
            {
                input = cols[x].firstChild;    
                input.id = listName + rowIndex + '.' + fields[x];
                input.setAttribute('name', listName + '[' + rowIndex + '].' + fields[x]);
            }

            rowIndex++;
        });


    };

    let addCancelOption = function () 
    {

        let fields = ['days:int', 'devolution:double'];         
        let listName = 'cancelOptions';
        let table = document.getElementById('cancelOptionsList');
        let tbody = table.getElementsByTagName('tbody')[0];

        let rowIndex = tbody.getElementsByTagName('tr').length;

        let tr = document.createElement('tr');

        fields.forEach((field,index) => {
           let td = document.createElement('td');
           let input = createInput(listName, rowIndex, field); 

           input.className = "cancelInput";

           if ( index === 0 )
           {
               let div = document.createElement('div');
               div.className = "inline";

               let lbBefore = document.createElement('div');
               let lbAfter = document.createElement('div');

               lbBefore.className = "label";
               lbAfter.className = "label";                   

               lbBefore.innerHTML = "Antes de ";                                      
               lbAfter.innerHTML = " dias para o checkin.";      

               div.appendChild(lbBefore);                  
               div.appendChild(input);
               div.appendChild(lbAfter);
               td.appendChild(div);

           }
           else
           {
               td.appendChild( input);
           }


           tr.appendChild(td);
       });

       let td = document.createElement('td');
       td.className = "middle";
       td.innerHTML = "<i class='fa fa-close' onclick='removeCancelOption(this)'></i>";
       tr.appendChild(td);

       tbody.appendChild(tr);  
       showCancelOptionsList();
    };

    let removeCancelOption = function ( el ) 
    {

        let tr = el.closest("tr");
        let tbody = tr.closest("tbody");            

        tbody.removeChild( tr );

        showCancelOptionsList();

        let rowIndex = 0;

        $(tbody).find('tr').each(function() 
        {                
            let cols = this.cells;

            let fields = ['days','devolution']; 
            let listName = 'cancelOptions';

            for (var x = 0;x < cols.length; x++)
            {
                input = cols[x].firstChild;    
                input.id = listName + rowIndex + '.' + fields[x];
                input.setAttribute('name', listName + '[' + rowIndex + '].' + fields[x]);
            }

            rowIndex++;
        });                        
    };

    let addImage = function ( media ) 
    {            
        let row = document.querySelector('#uploadList');            
        let index = $("#uploadList").children().length;                         
        let input = document.createElement('input');

        input.id = "medias" + index + ".name";
        input.type = "hidden";
        input.setAttribute('name', "medias" + '[' + index + '].' + "name");
        input.value = media.name ;

        let divCol = document.createElement('div');
        divCol.className = "unit-form-image-item";


        let img = document.createElement('div');
        let url = ctx + "/images/temp/units/"+media.name;
        img.className = "unit-form-image";
        img.style= "background-image: url("+url+")";


        let closeBt = document.createElement('i');
        closeBt.className = "closebt fa fa-close";

        closeBt.onclick = function() {
               removeImage(this);
        }

        divCol.appendChild( input );
        divCol.appendChild( img );
        //divThumbnail.appendChild( img );
        divCol.appendChild( closeBt );

        row.appendChild(divCol); 
        showUploadsList();
    };

    let removeImage = function ( el ) 
    {            
        let col = el.closest("div[class^='unit-form-image-item']");
        let uploadList = document.getElementById('uploadList');

        col.parentNode.removeChild(col);

        showUploadsList();

        let rowIndex = 0;

        $(uploadList).find('.unit-form-image').each(function() 
        {            

            $(this).find("input").each(function()
            {                    
                if ( this.id.endsWith("name"))
                {
                    this.id = "medias" + rowIndex + ".name";
                    this.setAttribute('name', "medias" + '[' + rowIndex + '].' + "name");
                }
                else if ( this.id.endsWith("idMedia"))
                {
                    this.id = "medias" + rowIndex + ".idMedia";
                    this.setAttribute('name', "medias" + '[' + rowIndex + '].' + "idMedia");
                }

            });

            rowIndex++;

        });                        
    };

    let showUploadsList = function ()
    {             
        let size = $("#uploadList").children().length;

        let showList = size > 0;

        document.getElementById('uploadList').style.display = showList ? 'block' : 'none';
        document.getElementById('noUploadsLabel').style.display = !showList ? 'block' : 'none';

    };

    let onFileSelected = function (e)
    {
        $("#uploadMessageDialog").modal();
        $(".fa fa-plus").prop('disabled',true);

        var file = document.getElementById('fileInput').files[0];

        if ( file.size <= 10485760 )
        {

            var fd = new FormData();
            fd.append("multipartFile", file);

            //var dt = {multipartFile: file};

            // Ajax call for file uploaling
            var ajaxReq = $.ajax(
            {
              url : 'uploadUnitMedia.html',
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
              addImage( media );
              $('#alertMsg').attr('class', 'sucessMsg');
              $('#alertMsg').text("Upload realizado com sucesso");
              $('#fileInput').val('');
              $('.fa fa-plus').prop('disabled',false);
            });

            // Called on failure of file upload
            ajaxReq.fail(function(jqXHR) {
              $('#alertMsg').attr('class', 'errorMsg');  
              $('#alertMsg').text('('+jqXHR.status+
                        ' - '+jqXHR.statusText+')');
              $('.fa fa-plus').prop('disabled',false);
            });
        }
        else
        {
            $('#alertMsg').attr('class', 'errorMsg');
            $('#alertMsg').text("Tamanho do arquivo não pode exceder 10mb.");
        }
    };

    function calculateFinalPrice( rowIndex )
    {
        var id = "disponibilities"+rowIndex+".price";
        var el = document.getElementById(id);
        var price = parseFloat(el.value); //$('#disponibilities'+rowIndex+'.price').val();

        if ( price )
        {
            var finalPrice = price + ( price * 0.1 );

            id = "disponibilities"+rowIndex+".finalPrice";
            el = document.getElementById(id);

            el.innerHTML = "(Valor + Taxas) = " + finalPrice;
            //$('#disponibilities'+rowIndex+'.finalPrice').html( finalPrice );
        }

    }
    
    function submitMainForm()
    {
        var spinner = $('.loader');

        spinner.show();

        document.getElementById("unitForm").submit();
    }

</script>
</head>
   
<div class="center-box box-column" style="padding-top: 20px; padding-bottom: 20px; ">
    <fmt:setLocale value="pt-BR"/>
    <c:choose>
    <c:when test="${unit != null}">
    <form:form id="unitForm" method="post" modelAttribute="unit" action="updateUnit.html" class="unit-form">    
        <div class="unit-form-box" >
            <div class = "unit-form-title">Atualização de Unidade</div> 
            <div class = "unit-form-groups">
                <div class="form-group">
                    <label> Hotel  </label>
                    <input type="text"  id="hotelSearch" value="${hotelSearch}"/>                            
                    <form:hidden id="token" path="token" />
                    <form:hidden id="idHotel" path="idHotel" />
                    <form:hidden id="idUnit" path="idUnit" />
                    <form:hidden id="validationStatus" path="validationStatus" />
                </div> 
                <div class="form-group">
                    <form:label path="room">Quartos</form:label>
                    <form:input class="intField" path="room" /><form:errors path="room" cssClass="error"/>
                </div>  
                <div class="form-group">
                    <form:label path="bedRoom">Camas</form:label>
                    <form:input class="intField" path="bedRoom" /><form:errors path="bedRoom" cssClass="error"/>
                </div>  
                <div class="form-group">
                    <form:label path="bathRoom">Banheiros</form:label>

                    <fmt:formatNumber type="number" 
                    minFractionDigits="2" maxFractionDigits="2" value="${unit.bathRoom}"
                    var="bath"/>
                    <form:input class="numberField" path="bathRoom" value="${bath}" /> <form:errors path="bathRoom" cssClass="error"/>
                </div>  
                <div class="form-group">
                    <form:label path="person">Pessoas</form:label>
                    <form:input class="intField" path="person" /><form:errors path="person" cssClass="error"/>
                </div>  
                <div class="form-group">
                    <form:label path="description">Descrição</form:label>
                    <form:textarea path="description" rows="10" cols="30" />
                </div>
            </div>
        </div>   
        <div class="unit-form-box" >
            <div class = "unit-form-box-header">
                <div class = "unit-form-box-title">Comodidades</div>
           
            </div>
            <div class = "unit-form-box-content">
                <div class="unit-form-box-checkbox-grid">
                    <form:checkboxes items = "${generalAttributes}" multiple="true" path = "attributes" itemLabel="name" itemValue="idAttribute" element="li" />
                </div>    
            </div>
        </div>
            
        <div class="unit-form-box" >
            <div class = "unit-form-box-header">
                <div class = "unit-form-box-title">Opções de Cancelamento</div>
                <div class="unit-form-box-buttons">
                    <i class="fa fa-plus" onclick="addCancelOption()"></i>
                </div>                
            </div>            
            <div class = "unit-form-box-content">
                <table id="cancelOptionsList" class="table" >
                <thead>    
                    <tr>
                        <th style="min-width:120px">Período</th>
                        <th style="min-width:120px">Devolução(%)</th>   
                        <th> </th>
                    </tr>                                  
                </thead>
                <tbody>
                    <c:forEach items="${unit.cancelOptions}" var="cancelOptions" varStatus="status">
                        <tr>
                            <form:hidden id="cancelOptions${status.index}.idCancelOption" path="cancelOptions[${status.index}].idCancelOption"/>  
                            <form:hidden id="cancelOptions${status.index}.idUnit" path="cancelOptions[${status.index}].idUnit"/>  
                            <td>
                                <div class="inline"> 
                                    <div class="label">Antes de </div>
                                    <form:input class="cancelInput" id="cancelOptions${status.index}.days" type="text" path="cancelOptions[${status.index}].days"/>
                                    <div class="label"> dias para o checkin.</div>
                                    <form:errors path="cancelOptions[${status.index}].days" cssClass="error"/>
                                </div>
                            </td>
                            <td><form:input id="cancelOptions${status.index}.devolution" type="text" path="cancelOptions[${status.index}].devolution"/> <form:errors path="cancelOptions[${status.index}].devolution" cssClass="error"/></td>                                    
                            <td class="middle"><i class="fa fa-close" onclick="removeCancelOption(this)"></i></td>
                        </tr>
                    </c:forEach>        
                </tbody>    
                </table>
                
                <c:set var="emptyCancelOptions">
                    <form:errors path="cancelOptions"/>
                </c:set>
                                                        
                <span class="${not empty emptyCancelOptions ? "error" : ""} noItemsLabel" id="noCancelOptionsLabel"> <center> Nenhuma opção de cancelamento registrada! </center></span>
                                
            </div>
        </div>
        <div class="unit-form-box" >
            <div class = "unit-form-box-header">
                <div class = "unit-form-box-title">Disponibilidades</div>
                <div class="unit-form-box-buttons">
                    <i class="fa fa-plus" onclick="addDisponibility()"></i>
                </div>
            </div>            
            <div class = "unit-form-box-content">
                <div class="table-responsive">
                    <table id="dispList" class="table" >
                        <thead>    
                        <tr>
                            <th style="min-width:50px">Noites</th>
                            <th style="min-width:120px">Data Inicial</th>
                            <th style="min-width:120px">Data Final</th>    
                            <th style="min-width:110px">Preço</th>                   
                            <th style="min-width: 22px"></th>                   
                        </tr>                                  
                        </thead>
                        <tbody>
                            <c:forEach items="${unit.disponibilities}" var="disponibilities" varStatus="status">
                                <tr>
                                    <form:hidden id="disponibilities${status.index}.idDisponibility" path="disponibilities[${status.index}].idDisponibility"/>  
                                    <form:hidden id="disponibilities${status.index}.idUnit" path="disponibilities[${status.index}].idUnit"/>  
                                    <td><form:input id="disponibilities${status.index}.nights" type="text" path="disponibilities[${status.index}].nights"/><form:errors path="disponibilities[${status.index}].nights" cssClass="error"/></td>
                                    <td><form:input id="disponibilities${status.index}.startDate" type="date" path="disponibilities[${status.index}].startDate"/> <form:errors path="disponibilities[${status.index}].startDate" cssClass="error"/></td>
                                    <td><form:input id="disponibilities${status.index}.endDate" type="date" path="disponibilities[${status.index}].endDate"/><form:errors path="disponibilities[${status.index}].endDate" cssClass="error"/></td>
                                    <td><form:input id="disponibilities${status.index}.price" type="text" path="disponibilities[${status.index}].price" onChange="calculateFinalPrice(${status.index});" /><div class="text-danger" id="disponibilities${status.index}.finalPrice">(Valor + Taxas) = ${disponibilities.price + (disponibilities.price * 0.1) }</div><form:errors path="disponibilities[${status.index}].price" cssClass="error"/></td> 
                                    <td class="middle"><i class="fa fa-close" onclick="removeDisponibility(this)"></i></td>
                                </tr>
                            </c:forEach>        
                        </tbody>                                                                                                                                     
                    </table>
                </div>    
                
                <c:set var="emptyDiponibilities">
                    <form:errors path="disponibilities"/>
                </c:set>

                <span class="${not empty emptyDiponibilities ? "error" : ""} noItemsLabel" id="noDispsLabel"> <center> Nenhuma diponibilidade registrada! </center></span>
                                                
            </div>
        </div>
        
        <div class="unit-form-box" >
            <div class = "unit-form-box-header">
                <div class = "unit-form-box-title">Fotos</div>
                <div class="unit-form-box-buttons">
                    <i class="fa fa-plus" onclick="document.getElementById('fileInput').click();"></i>
                </div>
            </div> 

            <form id="fileUpload" action="fileUpload" method="post" enctype="multipart/form-data">
                <input class="form-control" type="file" name="file" accept="image/*" id="fileInput" style="display:none;" onchange="onFileSelected(event);">
            </form>

             <div> <center style="background: #ffe0b2"> Tamanho máximo permitido: 10Mb </center></div>    
            
            <div id="uploadList" class="images-box">
                <c:forEach items="${unit.medias}" var="medias" varStatus="st">
                    <div class="unit-form-image-item">
                        <form:hidden id="medias${st.index}.idMedia" path="medias[${st.index}].idMedia"/> 
                        <form:hidden id="medias${st.index}.name" path="medias[${st.index}].name"/>  

                        <div class="unit-form-image" style="background-image: url(${pageContext.request.contextPath}/images/base/units/${medias.name})"> </div>                                                
                        <i class="closebt fa fa-close" onclick="removeImage(this)"></i>
                    </div>                                         
                </c:forEach> 
            </div>
                            
            <c:set var="emptyMedias">
                <form:errors path="medias"/>
            </c:set>

            <span class="${not empty emptyMedias ? "error" : ""} noItemsLabel" id="noUploadsLabel" style="min-height: 150px; display: block;"> <center> Nenhuma foto registrada! </center></span>
                            
        </div>    
        
        <div class="unit-form-box" >    
            <div class="buttonGroup">
                <center>
                    <button type="button" class="btn submit-button" onClick="submitMainForm();">Atualizar</button>
                    <button type="button" class="btn close-button" onClick="location.href = 'unit.html'">Fechar</button>
                </center>    
            </div> 
        </div>
    
        <div id="uploadMessageDialog" class="modal fade" role="dialog">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content">

                    <div class="modal-header">
                        <div class="progress">
                            <div id="progressBar" class="progress-bar progress-bar-success" role="progressbar"
                                aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">0%
                            </div>
                        </div>  

                        <div id="alertMsg" class="errorMsg"></div>  
                    </div>                                                                    
                    <div class="modal-footer">
                        <button type="button" class="btn close-button" data-dismiss="modal">Fechar</button>                                        
                    </div>
                </div>
            </div>

        </div>
    </form:form>
    </c:when>
    <c:otherwise>
      
        <table>       
        <tr>
            <td>
                <div class="alert alert-danger">
                    <strong>${message}</strong>
                </div>                    
            </td>
        </tr>   
        </table>   
      
    </c:otherwise>
    </c:choose>
</div>    
    
<div class="loader"></div>        
    
       
<script>

   

    
</script>
  
   
