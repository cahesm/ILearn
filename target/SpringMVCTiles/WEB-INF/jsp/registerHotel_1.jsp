<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

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
            divCol.className = "img-item";
            
            let img = document.createElement('div');
            let url = ctx + "/images/temp/hotels/"+media.name;
            img.className = "resort-image";
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
        }
        
        let removeImage = function ( el ) 
        {            
            let col = el.closest("div[class^='img-item']");
            let uploadList = document.getElementById('uploadList');
            
            col.parentNode.removeChild(col);
            
            showUploadsList();
                        
            let rowIndex = 0;
            
            $(uploadList).find('.img-item').each(function() 
            {                            
                $(this).find("input").each(function()
                {                    
                    if ( this.id.endsWith("name"))
                    {
                        this.id = "medias" + rowIndex + ".name";
                        this.setAttribute('name', "medias" + '[' + rowIndex + '].' + "name");
                    }                                        
                });
                                                
                rowIndex++;
                
            });                          
        }
        
        let showUploadsList = function ()
         {             
             let size = $("#uploadList").children().length;
             
             let showList = size > 0;
             
             document.getElementById('uploadList').style.display = showList ? 'block' : 'none';
             document.getElementById('noUploadsLabel').style.display = !showList ? 'block' : 'none';
             
         }
                        
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
        }
         
        

     </script>

<html>
<head>
	<title>Registro de Hotel</title>
        <style>
             .error
            {
                color: #ff0000;
                font-weight: bold;
                font-size: 12px;
            }
            
            .noItemsLabel {
             padding:15px;
         }
            
           
                                        
          .closebt {
                               
            font-size:18px;
          }
         
            .img-item {
                display: flex;                                             
                padding: 0px !important;                
                margin-top: 10px;   
                margin-bottom: 15px !important;
                margin-left: 15px !important;
                margin-right: 10px !important;
            }
            
            .panel-group{
    padding-bottom: 0px;
}

.panel-body{    
    border-radius: 0px 0px 5px 5px;
    background-color: snow !important;
    min-height: 150px;
    border: 1px solid cadetblue !important; 
    border-top: 0px !important;
}

.panel-body table{    
    margin-bottom: 0px !important;
}

.noRadius
{
    border-radius: 0px !important;
}

.noBottomRadius
{
    border-bottom-left-radius:  0px !important;
    border-bottom-right-radius: 0px !important;
}

.resort-image {
    background-color: rgba(0,0,0,0.3);
    width: 200px;        
    height: 136px;
    overflow: hidden;
    background-size: cover;
    background-position: center;
}

.centered
{
    justify-content: center;
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

.btn{
    width: 150px;
    margin-top: 10px;
}


@media only screen and (max-width: 35.5em)
{
    .buttonGroup button[type="button"]
    {
        width: 80%;
    }
    
    .buttonGroup{
        text-align: center !important;;
    }
    
}

.buttonGroup{
        text-align: right;
        padding: 10px 20px 10px 20px;
        
    }
    
    
    .form-group {
  display: block;
  margin: 0px !important;
  padding: 10px 20px 10px 20px;
  
}

.form-group a{
  font-size: 12px;
}

label{
    margin: 0px !important;
    margin-top: 5px !important;
    color: cadetblue;
}

input, textarea, select{
    border:none !important;
    border-bottom: 1px solid cadetblue !important;    
    border-radius: 0px !important;
    outline: none !important;        
    background: transparent !important;
    padding: 0px !important;
    margin: 0px !important;
    font-size: 13px;
    
}

textarea{
    padding-top: 10px !important;
}

input:focus {
    background: transparent !important;
}

input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
input:-webkit-autofill:active {
transition: background-color 5000s ease-in-out 0s;
    
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

.fa-close, .fa-plus
{
    cursor: pointer;
}



        </style>
</head>
<body>
<div class="hd_center_container">
    <div class="center" id="hd_dashboard_horzmenu">   
<% if(  request.getAttribute("success")!=null ) { %>
<table>       
<tr>
		<td>
                     <div class="alert alert-success">
                    <strong>Sucesso!</strong> <%=request.getAttribute("success").toString()%>
                    </div>                     
                </td>
        </tr>   
</table>        
<%} else { %> 

 <form:form id="hotelForm" method="post" modelAttribute="hotel" action="processHotel.html">
<div class = "panel-group">
    <div class = "panel panel-default">
        <div class = "panel-heading">
            <h4 class = "panel-title">
                 <a data-toggle = "collapse" href = "#hotelList">Registro de Hotel</a>                     
            </h4>
            <div class="panel-buttons">
                <a href="hotel.html">
                    <i class="fa fa-close" ></i>
                </a>
            </div>    
        </div> 
        
        <div id = "hotelList" class = "collapse show" aria-expanded="true">
            <div class = "panel-body noBottomRadius"> 
                <div class="form-group">
                    <form:label path="name">Nome</form:label>
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
    </div>
</div>        
<div class = "panel-group">
            <div class = "panel panel-default">
                <div class = "panel-heading noRadius">
                    <h4 class = "panel-title">
                         <a data-toggle = "collapse" href = "#hotelPictures">Fotos</a>                     
                    </h4>
                    <div class="panel-buttons">
                        <i class="fa fa-plus" onclick="document.getElementById('fileInput').click();"></i>
                    </div>    
                </div>                                  
                <div id = "hotelPictures" class = "collapse show" aria-expanded="true">
                        <div class = "panel-body"> 
                            <form id="fileUpload" action="fileUpload" method="post" enctype="multipart/form-data">
                                <input class="form-control" type="file" name="file" accept="image/*" id="fileInput" style="display:none;" onchange="onFileSelected(event);">
                            </form>
                             <span> <center style="background: #ffe0b2"> Tamanho máximo permitido: 10Mb </center></span>

                            <div id="uploadList" class="row centered">
                                <c:forEach items="${hotel.medias}" var="medias" varStatus="st">
                                <div class="img-item">
                                    <form:hidden id="medias${st.index}.idMedia" path="medias[${st.index}].idMedia"/> 
                                    <form:hidden id="medias${st.index}.name" path="medias[${st.index}].name"/>  
                                        <div class="resort-image" style="background-image: url(${pageContext.request.contextPath}/images/temp/hotels/${medias.name})"> </div>                                                
                                            <i class="closebt fa fa-close" onclick="removeImage(this)"></i>
                                    
                                    </div>    
                                     
                            </c:forEach> 
                            </div>
                            
                            <c:set var="emptyMedias">
                            <form:errors path="medias"/>
                            </c:set>

                            <span class="${not empty emptyMedias ? "error" : ""} noItemsLabel" id="noUploadsLabel" style="min-height: 150px; display: block;"> <center> Nenhuma foto registrada! </center></span>
                                                      
                            
                            <div class="buttonGroup">          
                                <button type="button" class="btn btn-primary" onClick="submitMainForm();">Registrar</button>
                                <button type="button" class="btn btn-secondary" onClick="location.href = 'hotel.html'">Fechar</button>
                            </div>
                        </div>
                </div>
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
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>                                        
                    </div>
                    </div>
                    </div>

        </div>                         
    
</form:form>
  <div class="loader"></div>           
   
<%}%> 

<script>
    showUploadsList();
    
    function submitMainForm()
    {                    
        var spinner = $('.loader');
           
        spinner.show();
           
        document.getElementById("hotelForm").submit();
    }
    
    $('#hotelForm').submit(function() {
    
    //$('#continent').val ( $('#continents').children('option:selected').text() );
    //$('#country').val( $('#countries').children('option:selected').text() );
    //$('#state').val( $('#states').children('option:selected').text() );
    //$('#city').val ( $('#cities').children('option:selected').text() );
    
    return true; // return false to cancel form action
});
    
    </script>
    </div>
</div>
</body>
</html>