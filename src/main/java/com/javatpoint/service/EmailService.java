/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javatpoint.service;

/**
 *
 * @author usuario
 */
public interface EmailService {
    
    public void sendMessage( String dest, String subject, String body );
    
}
