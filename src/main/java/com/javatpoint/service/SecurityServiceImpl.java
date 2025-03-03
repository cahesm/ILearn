/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javatpoint.service;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;





/**
 *
 * @author usuario
 */
public class SecurityServiceImpl 
        implements 
            SecurityService 
{
    
    private final  String secret = "t0102w030440506r";
    
    
    private SecretKeySpec setKey( String myKey ) 
    {       
        SecretKeySpec secretKey = null;
        try 
        {
            MessageDigest sha = null;
            byte[] key  = myKey.getBytes("UTF-8");
            sha = MessageDigest.getInstance("SHA-1");
            key = sha.digest(key);
            key = Arrays.copyOf(key, 16); 
            secretKey = new SecretKeySpec(key, "AES");                       
        } 
        catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } 
        catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        
         return secretKey;
    }
    
public String encrypt(String strToEncrypt)
{   
    String result = null;
    try 
    {
        SecretKeySpec secretKey = setKey( secret );
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        result = Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes("UTF-8")));
    }
    catch (Exception e) 
    {
        e.printStackTrace();
    }   
    
    return result;
}

public String decrypt(String strToDecrypt){

    String result = null;
    
    try 
    {
        SecretKeySpec secretKey = setKey( secret );
        Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        result = new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
    }
    catch( Exception e )
    {   
        e.printStackTrace();
    }
    
    return result;
}
    
}
