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
public interface SecurityService {
    
    public String encrypt( String pass );
    public String decrypt( String pass );
    
}
