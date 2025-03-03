package com.javatpoint.controller;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import com.javatpoint.model.Contact;
import com.javatpoint.service.EmailService;
import com.javatpoint.util.RecaptchaVerification;
import com.javatpoint.validator.ContactValidator;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.servlet.ModelAndView;



@Controller
@SessionAttributes
public class ContactController {
    
    @Autowired  
  EmailService emailService;
    
  @Autowired
  ContactValidator contactValidator;  
    
    @InitBinder("contact")
   protected void initUnitBinder(WebDataBinder binder) {
      binder.addValidators(contactValidator);
   }
    
    @RequestMapping(value = "/processContact", method = RequestMethod.POST)
    public String processContact(@ModelAttribute("contact") @Validated Contact  contact, BindingResult result, Model model, HttpServletRequest request) throws IOException {
            //write the code here to add contact
            model.addAttribute("contact",contact);
            
            String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
            
            boolean verifyCaptcha = RecaptchaVerification.verify(gRecaptchaResponse);

            if ( !verifyCaptcha )
            {               
                model.addAttribute("errorCaptcha", "Recaptcha inválido!" );
                return "contact";
            }
            
            if ( result.hasErrors() )
            {
                return "contact";
            }
            else
            {
            
                //ModelAndView mav = new ModelAndView("forward:contact.html");

                emailService.sendMessage( "contato@tw4r.com", "Contato pelo site", "Nome: "+ contact.getName() + "\nEmail: "+ contact.getEmail()+ "\nTelefone: "+ contact.getPhone()+ "\nMensagem:" + contact.getMessage());

                model.addAttribute("success","Mensagem enviada com sucesso!");
                
                //model.addAttribute("contact",new Contact());
                
                return "forward:contact.html";
                
                //mav.addObject("success", "Requisição enviada com sucesso!");
            }
            
            
        //return mav;
    }
    
	
}
