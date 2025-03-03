<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
	<title>Spring Tiles Contact Form</title>
        <style>
            .error
            {
                color: #ff0000;
                font-weight: bold;
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
            
        </style>
        
         <script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>
    
<% if(  request.getAttribute("success")!=null ) { %>
<table>       
<tr>
		<td>
                    <div class="ui blue message">
                         Link de confirmação foi enviado para o seu email<br>
                    </div>
                </td>
        </tr>   
</table>        
<%} else if(  request.getAttribute("message")!=null ) { %>     
   <table>       
        <tr>
		<td>
                    <div class="ui blue message">
                         <%=request.getAttribute("message").toString()%> <br>
                    </div>
                </td>
        </tr>   
</table>      
<%}%>
</body>
</html>
