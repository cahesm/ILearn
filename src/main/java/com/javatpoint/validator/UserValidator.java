/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javatpoint.validator;

import com.javatpoint.model.User;
import com.javatpoint.service.UserService;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class UserValidator implements Validator {

    @Autowired
    UserService userService;
    
    public boolean supports(Class clazz) {
      return User.class.equals(clazz);
    }

    
    public void validate(Object target, Errors errors) {
      User user = (User) target;

//      ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username",
//			"required.userName", "Field name is required.");
      
      User u = userService.getUser(user.getUsername());
      
      if ( u != null && u.getUsername().equals( user.getUsername()) && user.getIdUser() != u.getIdUser() )
      {
          errors.rejectValue("username", "", "Nome já cadastrado para outro usuário!");
      }
            
      if(user.getUsername() == null || user.getUsername().isEmpty()) 
      {
          errors.rejectValue("username", "", "Campo usuário é obrigatório!");
      }
      else if ( user.getUsername().length() > 16 )
      {
          errors.rejectValue("username", "", "Campo usuário não pode exceder 16 caracteres!");
      }
      
      if(user.getName() == null || user.getName().isEmpty()) 
      {
          errors.rejectValue("name", "", "Campo nome é obrigatório!");
      }
      else if ( user.getName().length() > 45 )
      {
          errors.rejectValue("username", "", "Campo usuário não pode exceder 45 caracteres!");
      }
      
      u = userService.getUserByEmail( user.getEmail() );
      
      if ( u != null && u.getEmail().equals( user.getEmail()) && user.getIdUser() != u.getIdUser() )
      {
          errors.rejectValue("email", "", "Email já cadastrado para outro usuário!");
      }
      
      if(user.getEmail() == null || user.getEmail().isEmpty()) 
      {
          errors.rejectValue("email", "", "Campo email é obrigatório!");
      }
      else if (!isValidEmailAddress (user.getEmail()))
      {
          errors.rejectValue("email", "", "Email inválido!");
      }
          
      
      if(user.getPassword() == null || user.getPassword().isEmpty()) 
      {
          errors.rejectValue("password", "", "Campo senha é obrigatório!");
      }
      else if ( user.getPassword().length() < 6 )
      {
          errors.rejectValue("password", "", "Valor para senha deve conter no mínimo 6 caracteres!");
      }
      
      if(user.getConfirmPassword() == null || user.getConfirmPassword().isEmpty()) 
      {
          errors.rejectValue("confirmPassword", "", "Campo confirmar senha é obrigatório!");
      }
      else if ( user.getConfirmPassword().length() < 6 )
      {
          errors.rejectValue("confirmPassword", "", "Valor para senha deve conter no mínimo 6 caracteres!");
      }
      
      if( user.getPassword() != null && !user.getPassword().isEmpty() && user.getConfirmPassword() != null && !user.getConfirmPassword().isEmpty() && !user.getPassword().equals( user.getConfirmPassword() ) ) 
      {
          errors.rejectValue("confirmPassword", "", "Valores para os campos de senha são diferentes!");
      }      
      // do "complex" validation here

    }
    
    private boolean isValidEmailAddress(String email) 
    {
        boolean result = true;
        try 
        {
           InternetAddress emailAddr = new InternetAddress(email);
           emailAddr.validate();
        } catch (AddressException ex) 
        {
           result = false;
        }
        return result;
    }


}
