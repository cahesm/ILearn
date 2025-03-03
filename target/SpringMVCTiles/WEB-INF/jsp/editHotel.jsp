<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script language="javascript">    
    var ctx = "${pageContext.request.contextPath}";
    
     function getStates(selectedCountry)
     {
         var data = { country : selectedCountry };
         
         $.ajax({
                
                url: "getStates.html",                
                type: 'post',                                
                data: data,  
                
                success: function(response){
                   var statesDropDown = $("#states"), citiesDropDown = $("#cities"), option= "";
                   var states = JSON.parse(response);
                    $.each(states, function(index, value){
                        option = option + "<option value='" + value.id + "'>" +value.name + "</option>";                        
                    });
                    
                    statesDropDown.empty();
                    statesDropDown.append(option);
                    statesDropDown.prop('selectedIndex',0);
                    citiesDropDown.prop('selectedIndex',0);
                },
                error:function(e){
                    alert("error " + e);
                }
            });
                                             
     }
     
     /*
     function getCountries( selectedContinent )
     {
         var data = { continent : selectedContinent };
         
         $.ajax({
                
                url: "http://localhost:8080/SpringMVCTiles/getCountries.html",                
                type: 'post',                                
                data: data,  
                
                success: function(response){
                   var countriesDropDown = $("#countries"), statesDropDown = $("#states"), citiesDropDown = $("#cities"), option= "";
                    $.each(response, function(index, value){
                        option = option + "<option value='" + value.id + "'>" +value.name + "</option>";                        
                    });
                    
                    countriesDropDown.empty();
                    countriesDropDown.append(option);
                    countriesDropDown.prop('selectedIndex',0);
                    statesDropDown.prop('selectedIndex',0);
                    citiesDropDown.prop('selectedIndex',0);
                },
                error:function(e){
                    alert("error " + e);
                }
            });
                                             
     }
     */
     
     function getCities( selectedState )
     {
         var data = { state : selectedState };
        
         $.ajax({
                
                url: "getCities.html",                
                type: 'post',                                
                data: data,  
                
                success: function(response){
                   var citiesDropDown = $("#cities"), option= "";
                   var cities = JSON.parse(response);
                    $.each(cities, function(index, value){
                        option = option + "<option value='" + value.id + "'>" +value.name + "</option>";                        
                    });
                    
                    citiesDropDown.empty();
                    citiesDropDown.append(option);
                    citiesDropDown.prop('selectedIndex',0);
                },
                error:function(e){
                    alert("error " + e);
                }
            });
                                             
     }

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
            divCol.className = "hotel-form-image-item";
            
            let img = document.createElement('div');
            let url = ctx + "/images/temp/hotels/"+media.name;
            img.className = "hotel-form-image";
            img.style= "background-image: url("+url+")";
            
            let closeBt = document.createElement('i');
            closeBt.className = "closebt fa fa-close";
            
            closeBt.onclick = function() {
                   removeImage(this);
            };
                                                           
            divCol.appendChild( input );
            divCol.appendChild( img );
            //divThumbnail.appendChild( img );
            divCol.appendChild( closeBt );
           
            row.appendChild(divCol);   
            
            showUploadsList();
        };
        
        let removeImage = function ( el ) 
        {            
            let col = el.closest("div[class^='hotel-form-image-item']");
            let uploadList = document.getElementById('uploadList');
            
            col.parentNode.removeChild(col);
            
            showUploadsList();
                        
            let rowIndex = 0;
            
            $(uploadList).find('.hotel-form-image-item').each(function() 
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
                  url : 'uploadHotelMedia.html',
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

     </script>


<head>
<meta charset = "utf-8">
<title>Registro</title>
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

</style>
</head>


<div class="center-box box-column" style="padding-top: 20px; padding-bottom: 20px; ">
    <c:choose>
    <c:when test="${hotel != null}">
    <form:form id="hotelForm" method="post" modelAttribute="hotel" action="updateHotel.html" class="hotel-form">    
        <div class="hotel-form-box" >
            <div class = "hotel-form-title">Atualização de Hotel</div> 
            <div class = "hotel-form-groups">                
                <div class="form-group">
                    <form:label path="name">Nome</form:label>
                    <form:hidden id="token" path="token" />
                    <form:hidden  path="idHotel" />
                    <form:hidden  path="address.idAddress" />
                    <form:input path="name" /><form:errors path="name" cssClass="error"/>
                </div> 
                <div class="form-group">
                    <form:label path="address.country">País</form:label>
                    <form:select id="countries" path="address.idCountry" items="${countryList}" itemValue="id" itemLabel="name" onchange="javascript:getStates(this.value);" />                                 
                    <form:errors path="address.idCountry" cssClass="error"/>
                </div> 
                <div class="form-group">
                    <form:label path="address.idState">Estado</form:label>
                    <form:select id="states" path="address.idState" items="${stateList}" itemValue="id" itemLabel="name" onchange="javascript:getCities(this.value);"/>                                
                    <form:errors path="address.idState" cssClass="error"/>
                </div> 
                <div class="form-group">
                    <form:label path="address.idCity">Cidade</form:label>
                    <form:select id="cities" path="address.idCity" items="${cityList}" itemValue="id" itemLabel="name"/>                                
                    <form:errors path="address.idCity" cssClass="error"/>
                </div> 
                <div class="form-group">
                    <form:label path="address.address">Endereço</form:label>
                    <form:input path="address.address" /><form:errors path="address.address" cssClass="error"/>
                </div> 
                <div class="form-group">
                    <form:label path="address.number">Número</form:label>
                    <form:input path="address.number" /><form:errors path="address.number" cssClass="error"/>
                </div> 
                <div class="form-group">
                    <form:label path="address.region">Região</form:label>
                    <form:input path="address.region" /><form:errors path="address.region" cssClass="error"/>
                </div> 
                <div class="form-group">
                    <form:label path="address.neighborhood">Bairro</form:label>
                    <form:input path="address.neighborhood" />
                </div>                 
                <div class="form-group">
                    <form:label path="site">Site</form:label>
                    <form:input path="site" />
                </div>                                             
            </div>
        </div>        
        <div class="hotel-form-box" >
            <div class = "hotel-form-box-header">
                <div class = "hotel-form-box-title">Fotos</div>
                <div class="hotel-form-box-buttons">
                    <i class="fa fa-plus" onclick="document.getElementById('fileInput').click();"></i>
                </div>
            </div> 

            <form id="fileUpload" action="fileUpload" method="post" enctype="multipart/form-data">
                <input class="form-control" type="file" name="file" accept="image/*" id="fileInput" style="display:none;" onchange="onFileSelected(event);">
            </form>

            <div> <center style="background: #ffe0b2"> Tamanho máximo permitido: 10Mb </center></div>    
             
            <div id="uploadList" class="images-box">
                <c:forEach items="${hotel.medias}" var="medias" varStatus="st">
                    <div class="hotel-form-image-item">
                        <form:hidden id="medias${st.index}.idMedia" path="medias[${st.index}].idMedia"/> 
                        <form:hidden id="medias${st.index}.name" path="medias[${st.index}].name"/>  
                        
                        <div class="hotel-form-image" style="background-image: url(${pageContext.request.contextPath}/images/base/hotels/${medias.name})"> </div>                                                
                        <i class="closebt fa fa-close" onclick="removeImage(this)"></i>
                        
                    </div>        
                </c:forEach> 
            </div> 
             
            <c:set var="emptyMedias">
                <form:errors path="medias"/>
            </c:set>
            <span class="${not empty emptyMedias ? "error" : ""} noItemsLabel" id="noUploadsLabel" style="min-height: 150px; display: block;"> <center> Nenhuma foto registrada! </center></span>
        </div>  
        
        <div class="hotel-form-box" >  
            <div class="buttonGroup">
                <center>
                    <button type="button" class="btn submit-button" onClick="submitMainForm();">Atualizar</button>
                    <button type="button" class="btn close-button" onClick="location.href = 'hotel.html'">Fechar</button>
                </center>    
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
</div>        

<div class="loader"></div>


<script>
    
    showUploadsList();
    
    function submitMainForm()
    {                 
        var spinner = $('.loader');
           
        spinner.show();
        
        document.getElementById("hotelForm").submit();
    }
    
    $('#hotelForm').submit(function() {
            
    return true; // return false to cancel form action
});
    
</script>
