package com.javatpoint.controller;
import com.javatpoint.model.Contact;
import com.javatpoint.model.Login;
import com.javatpoint.model.PasswordRecover;
import com.javatpoint.model.User;
import com.javatpoint.service.FaqService;
import com.javatpoint.service.SecurityService;
import com.javatpoint.service.UserService;
import com.javatpoint.util.AppUtilities;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class MenuController {
    
    @Autowired
    UserService userService;
    
    @Autowired
    FaqService faqService;
    
    @Autowired
    SecurityService securityService;
    
    @RequestMapping("/login")
	public String login( Model m ) {
		String message = "Credenciais";
                m.addAttribute("login", new Login());
		m.addAttribute("message", message);                
		return "login"; 
	}
        
    
        
    @RequestMapping("/register")
	public String register(Model m) {
		String message = "Registro";
                m.addAttribute("user", new User());
		m.addAttribute("message", message);
		return "register"; 
	}
        
    @RequestMapping("/forgotPassword")
	public String forgotPassword(Model m) {
		//String message = "Registro";
                m.addAttribute("passwordRecover", new PasswordRecover());                
		
		return "forgotPassword"; 
	}
        
        
        @RequestMapping("/contact")
	public String contact(Model m) {
		//String message = "Registro";
                m.addAttribute("contact", new Contact() );                
		
		return "contact"; 
	}
                                                             
    @RequestMapping("/terms")
	public String terms(Model m) {
		String message = "Termos";
		m.addAttribute("message", message);
		return "terms"; 
	}
        
    @RequestMapping("/about")
	public String about(Model m) {
		String message = "Sobre";
		m.addAttribute("message", message);
		return "about"; 
	}
        
    @RequestMapping("/faq")
	public String faq(Model m) {
		String message = "Sobre";
                                                
		m.addAttribute("message", message);
		m.addAttribute("faqList", faqService.getFaqs() );
		return "faq"; 
	}
        
    @RequestMapping("/privacy")
	public String privacy(Model m) {
		String message = "Política de Privacidade";
		m.addAttribute("message", message);
		return "privacy"; 
	}
        
    @RequestMapping("/flow")
	public String flow(Model m) {
		String message = "Fluxo";
		m.addAttribute("message", message);
		return "flow"; 
	}    
        
    @RequestMapping("/noOwnerPermission")
	public String noOwnerPermission(Model m) {
//		String message = "Sobre";
//		m.addAttribute("message", message);
		return "noOwnerPermission"; 
	}  
        
    @RequestMapping("/noAdminPermission")
	public String noAdminPermission(Model m) {
//		String message = "Sobre";
//		m.addAttribute("message", message);
		return "noAdminPermission"; 
	}    
        
        @RequestMapping("/account")
	public String account(Model m, HttpServletRequest request, HttpSession session) {
            
            String message = "Atualização";
            
            m.addAttribute("message", message);
            
            String target = AppUtilities.redirectToLogin( m, "account", request );
            
            if ( target == "account")
            {
                if ( session.getAttribute("modalMessage") != null )
                {
                    m.addAttribute("modalMessage", session.getAttribute("modalMessage") );
                    session.removeAttribute("modalMessage");
                }
                
                                
                User user = userService.getUser( request.getSession().getAttribute("username").toString() );
                
                //user.setPassword( securityService.decrypt( user.getPassword() ) );
                
                m.addAttribute("command", user );
            }
            
//            if ( request.getSession().getAttribute("user") == null )
//            {
//                m.addAttribute("command", new User());                
//                m.addAttribute("error", "Ação necessita que login seja efetuado!");
//                request.getSession().setAttribute("redirect", "account");
//                return "login";
//            }
//            
//            m.addAttribute("command", (User)request.getSession().getAttribute("user"));                
//                       
	    return target; 
	}
        
        @RequestMapping("/validate")
	public String validate(Model m, HttpServletRequest request) {
            
            String message = "Atualização";
            
            m.addAttribute("message", message);
            
            String target = AppUtilities.redirectToLogin( m, "validate", request );
            
            if ( target == "validate")
            {
                User user = userService.getUser( request.getSession().getAttribute("username").toString() );
                
                m.addAttribute("user", user );
            }
            
//            if ( request.getSession().getAttribute("user") == null )
//            {
//                m.addAttribute("command", new User());                
//                m.addAttribute("error", "Ação necessita que login seja efetuado!");
//                request.getSession().setAttribute("redirect", "account");
//                return "login";
//            }
//            
//            m.addAttribute("command", (User)request.getSession().getAttribute("user"));                
//                       
	    return target; 
	}
        
        
	
        
        
}
