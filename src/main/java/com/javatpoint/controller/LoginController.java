package com.javatpoint.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javatpoint.model.Login;

import com.javatpoint.model.Media;
import com.javatpoint.model.PasswordRecover;

import com.javatpoint.model.User;

import com.javatpoint.service.EmailService;
import com.javatpoint.service.MediaService;
import com.javatpoint.service.SecurityService;
import com.javatpoint.service.UserService;
import com.javatpoint.util.AppUtilities;
import com.javatpoint.util.RecaptchaVerification;
import com.javatpoint.validator.LoginValidator;
import com.javatpoint.validator.UserValidator;
import java.io.File;
import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@SessionAttributes
public class LoginController {

  @Autowired
  UserService userService;
  
  @Autowired
  private LoginValidator loginValidator;
  
  @Autowired  
  private UserValidator userValidator;
  
  @Autowired  
  private EmailService emailService;
  
  
  
  @Autowired
  SecurityService securityService;
  
  @InitBinder("login")
   protected void initLoginBinder(WebDataBinder binder) {
      binder.addValidators(loginValidator);
   }
   
  @InitBinder("user")
   protected void initUserBinder(WebDataBinder binder) {
      binder.addValidators(userValidator);
   }
   
  @RequestMapping(value = "/showUser", method = RequestMethod.POST)
	public String showUser(Model m, HttpServletRequest request, @RequestParam int id, @RequestParam String back) 
        {
            String target = AppUtilities.redirectToLogin( m, "showUser", request);
            
            if ( target == "showUser")
            {
                String message = "Unidade";
            
                User user = userService.getUser( id );

                m.addAttribute("message", message);
                m.addAttribute("back", back);

                m.addAttribute("user", user );                
            }
                                                                                                          
            return target;
	}
        
    @RequestMapping(value = "/processLogin", method = RequestMethod.POST)
    public String processLogin(@ModelAttribute("login") @Validated Login login, BindingResult result, Model model, HttpServletRequest request) throws IOException
    {

        request.getSession().removeAttribute("generatedContent");
        request.getSession().removeAttribute("questions");
                    
        model.addAttribute("login",login);
       
        if (result.hasErrors()) 
        {
           return "login";
        }
        else
        {

            User user = userService.validateUser(login);
            
            String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
            
            boolean verifyCaptcha = RecaptchaVerification.verify(gRecaptchaResponse);

            if ( !verifyCaptcha )
            {               
                model.addAttribute("errorCaptcha", "Recaptcha inválido!" );
                return "login";
            }
            else if (null != user) 
            {
                String target = "home";

                 
                if ( request.getSession().getAttribute("redirect") != null )
                {
                    String redirect = request.getSession().getAttribute("redirect").toString();
                    target = redirect.contains("redirect") ? redirect : "redirect:" + request.getSession().getAttribute("redirect").toString() + ".html";
                    request.getSession().removeAttribute("redirect");
                                        
                    //request.getSession().setAttribute("main", false );
                }
                else
                {
                    model.addAttribute("main", true );
                    //request.getSession().setAttribute("main", true );
                }
                
                if ( request.getSession().getAttribute("redirectAtts") != null )
                {
                    HashMap atts = (HashMap)request.getSession().getAttribute("redirectAtts");
                    
                    Iterator it = atts.entrySet().iterator();
                    while (it.hasNext()) {
                        Map.Entry pair = (Map.Entry)it.next();
                        model.addAttribute( pair.getKey().toString(), pair.getValue() );
                    }
                    
                    request.getSession().removeAttribute("redirectAtts");
                }

                 request.getSession().setAttribute("username", user.getUsername() );
                 request.getSession().setAttribute("userId", user.getIdUser());

//                 if ( user.isAdmin())
//                 {
//                    request.getSession().setAttribute("admin", true );
//                 }
                 
                 return target;

            } 
            else 
            {                
                model.addAttribute("error", "Usuário ou senha incorreta!");
                return "login";                       
            }
        }
      
   }
   

    
    @RequestMapping(value = "/processRegister", method = RequestMethod.POST )
    public String processRegister(@ModelAttribute("user") @Validated User user, BindingResult result, Model model, HttpServletRequest request) throws IOException 
    {
        request.setCharacterEncoding( "UTF-8");

        model.addAttribute("user",user);
      
        if (result.hasErrors()) 
        {
            return "register";
        }
        else
        {                        
            String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

            boolean verifyCaptcha = RecaptchaVerification.verify(gRecaptchaResponse);

            if ( !verifyCaptcha )
            {
                model.addAttribute("errorCaptcha", "Recaptcha inválido!");
                return "register";
            }
            else
            {            
                
                user.setPassword( securityService.encrypt( user.getPassword() ) );
                
                userService.register( user );
                
                emailService.sendMessage(user.getEmail(), "Registro na TW4R", 
                        "Caro Cliente,\n" +
                        "A equipe do ILearn agradece ao seu interesse e abertura de conta em nosso site.\n" +
                        "Nosso objetivo é proporcionar mais facilidade de conhecimento aos nossos usuários.\n" +
                        "\n" +
                        "Bons estudos.\n" +
                        "\n" +
                        "Qualquer dúvida entre em contato com nosso suporte." +
                        "\n\n Login: " + user.getUsername());
                
                
                model.addAttribute("success", "Usuário registrado com sucesso!");

                return "forward:register.html";
            }
        }
    }
    
    @RequestMapping(value = "/processAccount", method = RequestMethod.POST)
    public ModelAndView processAccount(@ModelAttribute("user")	User user, BindingResult result, HttpServletRequest request) {
            //write the code here to add contact
            
            User u = userService.getUser( user.getUsername() );
            
            if ( u != null )
            {
                if ( !u.getPassword().equals( user.getPassword() ) )
                {
                    user.setPassword( securityService.encrypt( user.getPassword() ) );
                }                                
            }
            
            userService.update( user );

            ModelAndView mav = new ModelAndView("forward:account.html");
            
             mav.addObject("success", "Alteração realizada com sucesso!");

        return mav;
    }
    
    
    @RequestMapping(value = "/logout")
    public String logout(Model m, HttpServletRequest request) 
    {
        request.getSession().removeAttribute( "username" );
        request.getSession().removeAttribute( "userId" );
        request.getSession().removeAttribute( "admin" );
        
        return "redirect:home.html";
    }
    
//    @RequestMapping(value = "/forgotPassword")
//    public String forgotPassword(Model m, HttpServletRequest request) 
//    {
//        m.addAttribute("command", "");
//        
//        return "forward:forgotPassword.html";
//    }
    
    @RequestMapping(value = "/recoverPassword", method = RequestMethod.POST)
    public ModelAndView recoverPassword(@ModelAttribute("passwordRecover") PasswordRecover passwordRecover, BindingResult result, HttpServletRequest request) {
            //write the code here to add contact
            
            ModelAndView mav = new ModelAndView("forward:forgotPassword.html");
            
            User user = userService.getUserByEmail( passwordRecover.getEmail() );
            
            if ( user != null )
            {
                emailService.sendMessage( passwordRecover.getEmail(), "Recuperação de Senha", "Caro usuário,\n você solicitou a recuperação de senha para acesso ao sistema da TW4R.\n\nSenha: " + securityService.decrypt( user.getPassword() ));
                mav.addObject("success", "Envio de email realizado com sucesso!");
            }
            else
            {
                mav.addObject("error", "Conta não encontrada para o email informado!");
            }
            


        return mav;
    }
    
    
    @RequestMapping("/managerUser")
	public String managerUser( Model m, HttpServletRequest request,  HttpSession session, @RequestParam( required = false ) Integer option, @RequestParam( required = false ) String c ) {
            
            HashMap atts = new HashMap();
            atts.put( "option", option);
            
            int op = option != null ? option : -1;
            
            String target = AppUtilities.redirectToLogin( m, "managerUser", request, atts);
            
            if ( target == "managerUser")
            {           
                int userId = (Integer)request.getSession().getAttribute("userId");

                User user = userService.getUser( userId );

//                if ( user.isAdmin())
//                {  
//                    ManagerUsersSearch search = new ManagerUsersSearch();
//                    
//                    if ( session.getAttribute("managerUsersSearch") != null )
//                    {
//                        search = (ManagerUsersSearch)session.getAttribute("managerUsersSearch");
//                        session.removeAttribute("managerUsersSearch");
//                    }
//                                                            
//                    search.setOption( op );
//                    
//                    if ( c != null && !c.isEmpty() )
//                    {
//                        byte[] decodedBytes = Base64.getMimeDecoder().decode(c);
//                        String cod = new String(decodedBytes);
//                        search.setCod( cod );
//                        
//                        search.setOption( -1 );
//                    }
//                    
//                    m.addAttribute("userList", userService.getUsersByFilter( search ));
//                    m.addAttribute("managerUsersSearch", search);
//                   
//                    m.addAttribute("option", op );                                        
//                }
//                else
                {
                    target=  "redirect:noAdminPermission.html";
                }
            }
                
            return target;
	}
    
        
    
}
  