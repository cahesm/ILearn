package com.javatpoint.controller;

import com.javatpoint.model.Question;
import com.javatpoint.util.AppUtilities;
import com.javatpoint.util.MistralClient;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
@Controller
public class GeneratorController {
    
    @RequestMapping(value = "/generator", method = RequestMethod.GET)
	public String generator( Model m, HttpServletRequest request, HttpSession session ) {
    
	
		//String message = "Hello World, Spring MVC @ Javatpoint";
            String target = AppUtilities.redirectToLogin( m, "generator", request);
            
            
                                  
            if ( target == "generator")
            {    
                m.addAttribute("main", true );
                //m.addAttribute("offers", new UnitsSearch() );
                
                
                //m.addAttribute("dispList", disponibilityService.getNewestDisponibilities() );
                
		//m.addAttribute("message", message);
		return "generator";
            }
            return target;
	}
        
        
    @PostMapping("/generate.html")
    public String generate(@RequestParam("topics") String question, HttpSession session) {
        // Simula um processamento do texto recebido (pode chamar IA ou outra lógica)
        //String generatedContent = "Conteúdo gerado com base em: " + question;
        String generatedContent = "";
        String generatedQuestions = "";
        List<Question> questions = new ArrayList();
        
        MistralClient client = new MistralClient();
        try
        {
            generatedContent = !question.isEmpty() ? client.chat(question) : "";
            
            questions  = client.generateQuestions( generatedContent);
        }
        catch(IOException e)
        {
            System.err.println(e.getMessage());
        }
        session.setAttribute("generatedContent", generatedContent);
        session.setAttribute("questions", questions);
        
        // Retorna a mesma página JSP para atualizar o conteúdo
        return "redirect:generator.html"; // Substitua pelo nome correto do seu arquivo JSP
    }
}
