<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
	<title>Registro</title>
        <style>
           .error
            {
                color: #ff0000;
                font-weight: bold;
                font-size: 12px;
            }
            
            .panel-body{    
    border-radius: 0px 0px 0px 0px;
    background-color: snow !important;
    min-height: 150px;
    border: 1px solid cadetblue !important;  
    border-top: 0px !important;
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

#hd_dashboard_horzmenu{
    max-width: 500px;
     box-shadow: 3px 5px 10px #bbb;
 -webkit-box-shadow: 3px 5px 10px #bbb;
}

.btn{
    width: 150px;
    margin-top: 10px;
}


@media only screen and (max-width: 35.5em)
{
    button[type="button"]
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

.form-group p{
  font-size: 12px;
  text-align: justify;
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
                    <strong>Requisição de Cadastro de Hotel enviada com sucesso!</strong>                    
                    </div>                       
                </td>
        </tr>   
</table>        
<%} else { %> 

<div class = "panel-group">
    <div class = "panel panel-default">
        <div class = "panel-heading">
            <h4 class = "panel-title">
                <a data-toggle = "collapse" href = "#requestHotel">Requisição para Cadastro de Hotel</a>                 
            </h4>
        </div>
        <div id = "requestHotel" class = "panel-collapse expand">
            <div class = "panel-body">        
                <form:form method="post" id="requestHotelForm" action="processRequestHotel.html" modelAttribute="hotelRequest">
                     <div class="form-group">
                           <p>O cadastramento de novos hotéis é realizado de acordo com as demandas de nossos proprietários parceiros. Informe o nome, endereço e o site de seu hotel para que possamos registrá-lo no nosso sistema. 
Assim que o mesmo esteja cadastrado lhe avisaremos por e-mail para que possa continuar o cadastramento de sua unidade.
</p>
                     </div>  
                     <div class="form-group">
                            <form:label path="info">Informações do Hotel</form:label>
                            <form:textarea path="info" rows="10" cols="30" />
                     </div>  
                     <div class="buttonGroup">
                          <button type="button" class="btn btn-primary" onClick="submitMainForm();">Enviar</button>
                     </div>    
                     
                     <% if(  request.getAttribute("error") != null ) { %>
                     <div class="form-group">  
                            <div class="error">                       
                                <%=request.getAttribute("error").toString()%>
                            </div>
                     </div>                 
                                
                          <%}%>
                                         
                </form:form>
            </div>
            <div class = "panel-footer"></div>                    
        </div>
    </div>
</div>      
<%}%> 
<div class="loader"></div>
</div>
</div>
</body>

<script>
    function submitMainForm()
    {                          
        var spinner = $('.loader');
            
        spinner.show();
        
        document.getElementById("requestHotelForm").submit();
    }
</script>

</html>