package com.javatpoint.controller;
import com.javatpoint.model.PasswordRecover;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    @RequestMapping("/")	
	public String index(){
		return "redirect:home.html";
	}
	


@RequestMapping("/home")
public String home(Model m) {
        //String message = "Registro";

        return "home"; 
}
	
}
