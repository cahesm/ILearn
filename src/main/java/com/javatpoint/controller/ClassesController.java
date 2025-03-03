package com.javatpoint.controller;

import com.javatpoint.model.Content;
import com.javatpoint.model.Question;
import com.javatpoint.model.StudyClass;
import com.javatpoint.model.User;
import com.javatpoint.service.StudyClassService;
import com.javatpoint.util.AppUtilities;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
@Controller
public class ClassesController {
    
    @Autowired
  StudyClassService classService;
    
	@RequestMapping(value = "/classes", method = RequestMethod.GET)
	public String listClasses( Model m, HttpServletRequest request, HttpSession session ) {
		//String message = "Hello World, Spring MVC @ Javatpoint";
                
                String target = AppUtilities.redirectToLogin( m, "classes", request);
            
            
                                  
            if ( target == "classes")
            {    
                m.addAttribute("main", true );
                
                int userId = (Integer)request.getSession().getAttribute("userId");
        
                List<StudyClass> classes = classService.getStudyClasses(userId);
                
                HashMap ids = new HashMap();

                    for( StudyClass c : classes )
                    {
                        String token = AppUtilities.generateNewToken();

                        c.setToken( token );

                        ids.put( token , c.getIdClass() );
                    }

                    session.setAttribute( "ids", ids );
                
                
                m.addAttribute("studyClasses", classes);
                
                //m.addAttribute("offers", new UnitsSearch() );
                
                
                //m.addAttribute("dispList", disponibilityService.getNewestDisponibilities() );
                
		//m.addAttribute("message", message);
		return "classes";
            }
            return target; 
	}
        
    @PostMapping("/saveClass.html")    
    public String saveClass(@RequestParam("className") String className, RedirectAttributes rm,HttpServletRequest request,HttpSession session) {
        // Simula um processamento do texto recebido (pode chamar IA ou outra lógica)
        //String generatedContent = "Conteúdo gerado com base em: " + question;
        String generatedContent = (String) session.getAttribute("generatedContent");
        List<Question> questions = (List<Question>) session.getAttribute("questions");

        int userId = (Integer)request.getSession().getAttribute("userId");
                
        StudyClass studyClass = new StudyClass();
        studyClass.setIdUser(userId);
        studyClass.setName(className);
        studyClass.setQuestions(questions);
        
        List<String> parts = new ArrayList();
        int maxLength = 3900;
        int length = generatedContent.length();
        for (int i = 0; i < length; i += maxLength ) {
            int end = Math.min(i + maxLength, length);
            parts.add(generatedContent.substring(i, end));
        }
        
        List<Content> contents = parts.stream().map( p -> { Content c = new Content(); c.setContent(p); return c;}).toList();
        
        studyClass.setContents(contents);
        
        classService.register(studyClass);
        
        session.removeAttribute("generatedContent");
        session.removeAttribute("questions");
        
        rm.addFlashAttribute("modalMessage", "Aula criada com sucesso");
        
        // Retorna a mesma página JSP para atualizar o conteúdo
        return "redirect:classes.html"; // Substitua pelo nome correto do seu arquivo JSP
    }

    @RequestMapping(value = "/deleteClass", method = RequestMethod.POST)
public String deleteClass(Model m, RedirectAttributes rm, HttpServletRequest request, @RequestParam String token)
{
    String target = AppUtilities.redirectToLogin( m, "redirect:classes.html", request);
            
    if ( target == "redirect:classes.html")
    {
        
        HashMap ids = (HashMap)request.getSession().getAttribute("ids");

        if ( ids.containsKey( token ))
        {            
            int id = (Integer)ids.get( token );


            StudyClass studyClass = classService.getStudyClass( id );

            classService.delete(studyClass);
            //classService.

            rm.addFlashAttribute("modalMessage", "Aula excluída com sucesso");
        }        
        else 
        {
            rm.addFlashAttribute("modalMessage", "Aula não encontrada");
        }

    }
        
    return target;
}
    
    
        
     @RequestMapping(value = "/showClass" )
	public String showClass(Model m, HttpServletRequest request, @RequestParam String token, HttpSession session) 
        {
            String target = AppUtilities.redirectToLogin( m, "redirect:showClass.html?token="+token, request);
                        
            HashMap ids = (HashMap)session.getAttribute("ids");
            
            if ( ids.containsKey( token ))
            {            
                int id = (Integer)ids.get( token );

                if ( target.contains( "showClass" ) )
                {
                                         
                    StudyClass sclass = null;
                    
                    sclass = classService.getStudyClass( id );                   
                    sclass.setToken( token );
                    
                    String generatedContent = "";
                    
                    for (Content c : sclass.getContents() )
                    {
                        generatedContent+= c.getContent();
                    }


                    m.addAttribute("className", sclass.getName() );
                    m.addAttribute("generatedContent", generatedContent );
                    m.addAttribute("generatedQuestions", sclass.getQuestions() );
                 
                    target = "showClass";
                }
            }
            else
            {
                m.addAttribute("message", "Unidade não encontrada. Por favor atualize a página.");
            }
                                                                                                          
            return target;
	}
}
