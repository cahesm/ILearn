<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="pt-BR" style='height: -webkit-fill-available;'>

<c:set var = "url" scope = "session" value = "${pageContext.request.scheme}://${pageContext.request.serverName}${pageContext.request.contextPath}"/>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <c:if test="${unit ne null && not empty c}">
         <meta property="og:url"                content="${url}/showUnit.html?c=${c}" />
         <meta property="og:type"               content="article" />
         <meta property="og:title"              content="${unit.hotel.name}" />
         <meta property="og:image" content="${url}/images/base/hotels/${unit.hotel.medias[0].name}">
         <meta property="og:description" content="${unit.description}">
    </c:if>  
    
    
       <title>  TW4R </title>
        
        <link href='https://fonts.googleapis.com/css?family=Poppins' rel='stylesheet'>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">        

        <link href="<c:url value='/resources/styles/style.css' />" rel="stylesheet"/>
        
        <link href="<c:url value="/resources/styles/login.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/styles/account.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/styles/register.css" />" rel="stylesheet">
        
        
        <link href="<c:url value="/resources/styles/user.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/styles/generator.css" />" rel="stylesheet">
        
       
        <link href="<c:url value='/resources/styles/bootstrap.min.css' />" rel="stylesheet"/>
        <link href="<c:url value='/resources/styles/bootstrap.css' />" rel="stylesheet"/>
         <link href="<c:url value='/resources/styles/header.css' />" rel="stylesheet"/>
        <link href="<c:url value='/resources/styles/footer.css' />" rel="stylesheet"/>
        
         <link href="<c:url value='/resources/styles/sidebar.css' />" rel="stylesheet"/>    
        <link href="<c:url value='/resources/styles/sidemenu.css' />" rel="stylesheet"/>        
        <link href="<c:url value='/resources/styles/sidefilter.css' />" rel="stylesheet"/> 
        <link href="<c:url value='/resources/styles/privacy.css' />" rel="stylesheet"/>
        <link href="<c:url value='/resources/styles/contact.css' />" rel="stylesheet"/> 
        <link href="<c:url value='/resources/styles/faq.css' />" rel="stylesheet"/> 
        
        <link href="<c:url value="/resources/styles/jquery-ui.css" />" rel="stylesheet">
        
        <link href="<c:url value="/resources/styles/slick.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/styles/slick-theme.css" />" rel="stylesheet">
        
                                      
        <script src="<c:url value='/resources/scripts/jquery.min.js' />"></script> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="<c:url value='/resources/scripts/sidemenu.js' />"></script>   
        <script src="<c:url value='/resources/scripts/sharer.js' />"></script>
        
        <script src="<c:url value="/resources/scripts/jquery-ui.js" />"></script>
        <script src="<c:url value="/resources/scripts/slick.min.js" />"></script>
        
                		
    </head>
    <body style='height: -webkit-fill-available;'>        
        <div style='display: flex; flex-direction: column; flex-grow: 1;'>
            <div class="header-layout" ><tiles:insertAttribute name="header" /></div>           
             <div class="center-layout" > <tiles:insertAttribute name="body" /></div>
             <div class="footer-layout"><tiles:insertAttribute name="footer" /></div>
        </div>
                                
    </body>
</html>