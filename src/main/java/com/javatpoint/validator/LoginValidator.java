/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javatpoint.validator;

import com.javatpoint.model.Login;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class LoginValidator implements Validator {

    
    public boolean supports(Class clazz) {
      return Login.class.equals(clazz);
    }

    
    public void validate(Object target, Errors errors) {
      Login login = (Login) target;

//      ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username",
//			"required.userName", "Field name is required.");
      
      if(login.getUsername() == null || login.getUsername().isEmpty()) 
      {
          errors.rejectValue("username", "required.userName", "Campo nome é obrigatório!");
      }
      
      if(login.getPassword() == null || login.getPassword().isEmpty()) 
      {
          errors.rejectValue("password", "required.password", "Campo senha é obrigatório!");
      }

      // do "complex" validation here

    }

}
