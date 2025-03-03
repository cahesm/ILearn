/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javatpoint.util;

import com.javatpoint.model.Login;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import org.springframework.ui.Model;

/**
 *
 * @author usuario
 */
public class AppUtilities 
{
    
    private static final SecureRandom secureRandom = new SecureRandom(); //threadsafe
    private static final Base64.Encoder base64Encoder = Base64.getUrlEncoder(); //threadsafe
    
    public static String redirectToLogin( Model m, String target, HttpServletRequest request )
    {
        return redirectToLogin( m, target, request, null );
    }
    
    public static String redirectToLogin( Model m, String target, HttpServletRequest request, HashMap atts )
    {
        if ( request.getSession().getAttribute("username") == null || request.getSession().getAttribute("userId") == null )
        {
            m.addAttribute("login", new Login());                
            //m.addAttribute("error", "Ação necessita que login seja efetuado!");
            request.getSession().setAttribute("redirect", target );
            
            if ( atts != null && !atts.isEmpty() )
            {
                request.getSession().setAttribute("redirectAtts", atts );
            }
            
//            if ( params != null && !params.isEmpty() )
//            {
//                request.getSession().setAttribute("params", params );
//            }
            
            return "redirect:login.html";
        }
        else
        {
            return target;
        }
    }
    
        
    public static String generateNewToken() 
    {
        byte[] randomBytes = new byte[24];
        secureRandom.nextBytes(randomBytes);
        return base64Encoder.encodeToString(randomBytes);
    }
    
}
