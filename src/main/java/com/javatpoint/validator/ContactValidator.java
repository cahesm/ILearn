/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javatpoint.validator;

import com.javatpoint.model.Contact;
import com.javatpoint.model.Login;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class ContactValidator implements Validator {

    
    public boolean supports(Class clazz) {
      return Contact.class.equals(clazz);
    }

    
    public void validate(Object target, Errors errors) {
      Contact contact = (Contact) target;

//      ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username",
//			"required.userName", "Field name is required.");
      
      if(contact.getName() == null || contact.getName().isEmpty()) 
      {
          errors.rejectValue("name", "required.name", "Campo nome é obrigatório!");
      }
      
      if(contact.getEmail() == null || contact.getEmail().isEmpty()) 
      {
          errors.rejectValue("email", "required.email", "Campo email é obrigatório!");
      }
      
      if(contact.getMessage() == null || contact.getMessage().isEmpty()) 
      {
          errors.rejectValue("message", "required.message", "Campo mensagem é obrigatório!");
      }

      // do "complex" validation here

    }

}
