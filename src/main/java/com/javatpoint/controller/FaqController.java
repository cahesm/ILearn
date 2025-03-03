package com.javatpoint.controller;


import com.javatpoint.model.Faq;
import com.javatpoint.model.Search;
import com.javatpoint.model.User;
import com.javatpoint.service.FaqService;
import com.javatpoint.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.javatpoint.util.AppUtilities;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@SessionAttributes
public class FaqController {

  @Autowired
  ServletContext context;   
    
  @Autowired
  FaqService faqService;
  
  @Autowired
  UserService userService;
  
           
//  @InitBinder("hotel")
//   protected void initHotelBinder(WebDataBinder binder) {
//      binder.addValidators(hotelValidator);
//   }
  

        
    @RequestMapping("/managerFaq")
	public String listFaqs( Model m, HttpServletRequest request, HttpSession session) {
                                                
            String target = AppUtilities.redirectToLogin( m, "managerFaq", request);
            
            if ( target.equals( "managerFaq") )
            {  
                int userId = (Integer)request.getSession().getAttribute("userId");
                
                User user = userService.getUser( userId );

//                if ( user.isAdmin())
//                {  
//
//                    Search filter = null; //new HotelsSearch();
//
//                    if ( session.getAttribute("faqSearch") != null )
//                    {
//                        filter = (Search)session.getAttribute("faqSearch");
//
//                        session.removeAttribute("faqSearch");
//                    }
//                    else
//                    {
//                        filter = new Search();
//                    }
//
//                    List<Faq> faqs = faqService.getFaqs( filter );
//
//                    HashMap ids = new HashMap();
//
//                    for( Faq faq : faqs )
//                    {
//                        String token = AppUtilities.generateNewToken();
//
//                        faq.setToken( token );
//
//                        ids.put( token , faq.getIdFaq() );
//                    }
//
//                    session.setAttribute( "ids", ids );
//
//                    if ( session.getAttribute("modalMessage") != null )
//                    {
//                        m.addAttribute("modalMessage", session.getAttribute("modalMessage") );
//                        session.removeAttribute("modalMessage");
//                    }
//
//
//                    m.addAttribute("faqs", filter);
//
//                    m.addAttribute("faqList", faqs );
//
//                    return "managerFaq"; 
//                }
//                else
                {
                    return "redirect:noAdminPermission.html";
                }
            }
            
            return target; 
	}    
  
    @RequestMapping("/addFaq")
	public String registerFaq( Model m, HttpServletRequest request, HttpSession session ) {
            
            String target = AppUtilities.redirectToLogin( m, "addFaq", request);
            
            if ( target == "addFaq")
            {
                int userId = (Integer)request.getSession().getAttribute("userId");

                User user = userService.getUser( userId );

//                if ( user.isAdmin())
//                {  
//                    Faq faq = null;
//
//                    if ( session.getAttribute("faq") != null )
//                    {
//                        faq = (Faq)session.getAttribute("faq");
//
//                        session.removeAttribute("faq");
//                    }
//                    else
//                    {                                
//                        faq = new Faq(); 
//                    }
//
//                    if ( session.getAttribute("binding") != null )
//                    {
//                        m.addAttribute("org.springframework.validation.BindingResult.faq", session.getAttribute("binding") );
//                        session.removeAttribute("binding");
//                    }
//                   
//                    m.addAttribute("faq", faq );   
//
//                   
//                }
//                else
                {
                    target=  "redirect:noAdminPermission.html";
                }
                

            }
            return target; 
	}    
        
   @RequestMapping(value = "/deleteFaq", method = RequestMethod.POST)
public String deleteFaq(Model m, RedirectAttributes rm, HttpServletRequest request, @RequestParam int id){
    
    String target = AppUtilities.redirectToLogin( m, "redirect:managerFaq.html", request);
    
    if ( target == "redirect:managerFaq.html")
    {
        int userId = (Integer)request.getSession().getAttribute("userId");

        User user = userService.getUser( userId );

//        if ( user.isAdmin())
//        {                   
//            faqService.delete( id );           
//        }
//        else
        {
            rm.addFlashAttribute("modalMessage", "Sem permissão para excluir dúvida. ");
        }
        
    }
    
    return target;
    
    
}

    @RequestMapping(value = "/editFaq" )
	public String editFaq(Model m, HttpServletRequest request, @RequestParam String token, HttpSession session) {
            
            String target = AppUtilities.redirectToLogin( m, "redirect:editFaq.html?token="+token, request);
            
            HashMap ids = (HashMap)session.getAttribute("ids");
            
            if ( ids.containsKey( token ))
            {
                int id = (Integer)ids.get( token );
                
                if ( target.contains( "editFaq") )
                {
                    int userId = (Integer)request.getSession().getAttribute("userId");

                    User user = userService.getUser( userId );

//                    if ( user.isAdmin())
//                    {  
//
//                        target = "editFaq";
//
//                        Faq faq = null;
//
//                        if ( session.getAttribute("faq") != null )
//                        {
//                            faq = (Faq)session.getAttribute("faq");
//
//                            session.removeAttribute("faq");
//                        }
//                        else
//                        {
//                            faq = faqService.getFaq( id );
//                        }
//
//                        if ( session.getAttribute("binding") != null )
//                        {
//                            m.addAttribute("org.springframework.validation.BindingResult.faq", session.getAttribute("binding") );
//                            session.removeAttribute("binding");
//                        }
//
//                        faq.setToken( token );
//
//                                             
//                        m.addAttribute("faq", faq );
//                    }
//                    else
                    {
                        target=  "redirect:noAdminPermission.html";
                    }
                }
            }            
            else
            {
                m.addAttribute("message", "Dúvida não encontrada. Por favor atualize a página.");
            }
            
                                                                                    
            return target;
                                                
	}
        
        
    @RequestMapping(value = "/processFaq", method = RequestMethod.POST)
    public String processRegister(@ModelAttribute("faq") @Validated Faq faq, BindingResult result, Model m, HttpServletRequest request, HttpSession session) 
    {
       
        if ( result.hasErrors() )
        {

            session.setAttribute("faq", faq);
            session.setAttribute("binding",result);  
            
            
            return "redirect:addFaq.html";
        }
        else
        {
            String target = AppUtilities.redirectToLogin( m, "redirect:managerFaq.html", request);

            if ( target == "redirect:managerFaq.html")
            {                                                
                faqService.register( faq );
                
                session.setAttribute("modalMessage","Dúvida adicionada com sucesso!");
            }

            return target;
        }        
    }
    
    @RequestMapping(value = "/updateFaq", method = RequestMethod.POST)
    public String updateFaq(@ModelAttribute("faq") @Validated Faq faq, BindingResult result, Model m, HttpServletRequest request, HttpSession session) 
    {
        
        if ( result.hasErrors() )
        {            
            session.setAttribute("faq",faq);
            session.setAttribute("binding",result);
            
            return "redirect:editFaq.html?token="+faq.getToken();
        }        
        else
        {
            String target = AppUtilities.redirectToLogin( m, "redirect:managerFaq.html", request);

            if ( target == "redirect:managerFaq.html")
            {                                                                  
                faqService.update( faq );
                session.setAttribute("modalMessage","Dúvida atualizada com sucesso!");
            }

            return target;
        }
    }
    
    
    
    @RequestMapping(value = "/searchFaqs", method = RequestMethod.POST)
    public String searchFaqs(@ModelAttribute("faqs") Search faqSearch, BindingResult result, Model m, HttpServletRequest request, HttpSession session) 
    {
         
       session.setAttribute("faqSearch",faqSearch);
          

       return "redirect:managerFaq.html";
    }
    
    
    


}
  