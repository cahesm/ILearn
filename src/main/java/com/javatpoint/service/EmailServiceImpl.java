/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javatpoint.service;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author usuario
 */
public class EmailServiceImpl 
        implements 
            EmailService 
{
    
    
//    private final static String SMTP_HOST = "mail.tw4r.com";
//    private final static String SENDER = "contato@tw4r.com";
//    
//    private final static String USER = "contato@tw4r.com";
//    private final static String PASS = "twcontato";
//   
    
    
    
    public void sendMessage( String dest, String subject, String body )
    {
//        final String username = "cahesm@gmail.com";
//        final String password = "";
        
        final String username = "cahesm@gmail.com";
        final String password = "sutd pyby mceb wrke";

        // Força uso do TLS 1.2
        System.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587"); // Porta 587 para TLS
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true"); // Habilita TLS
        prop.put("mail.smtp.ssl.protocols", "TLSv1.2"); // Garante uso de TLS 1.2

        Session session = Session.getInstance(prop, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(dest));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            System.out.println("E-mail enviado com sucesso!");
        }
        catch( Exception e )
        {
            System.out.println( e.getMessage() );
        }    
    }
    
    
//    public void sendMessage( String dest, String subject, String body )
//    {
//
//        Properties prop = new Properties();
//        prop.put("mail.smtp.host", SMTP_HOST);
//        prop.put("mail.smtp.port", "587");
//        prop.put("mail.smtp.auth", "true");
//        prop.put("mail.smtp.starttls.enable", "true"); //TLS
//        prop.put("mail.smtp.ssl.trust", SMTP_HOST);
//        prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
//        
//        Session session = Session.getInstance(prop,
//                new javax.mail.Authenticator() {
//                    protected PasswordAuthentication getPasswordAuthentication() {
//                        return new PasswordAuthentication(USER, PASS);
//                    }
//                });
//
//        try {
//
//            Message message = new MimeMessage(session);
//            message.setFrom(new InternetAddress(SENDER));
//            
//            Address[] toUser = InternetAddress.parse( dest );  
//
//            message.setRecipients(Message.RecipientType.TO, toUser);
//          
//            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
//                    
//            Multipart multipart = new MimeMultipart();
//         
//            BodyPart part1 = new MimeBodyPart();
//            part1.setContent( body, "text/html; charset=UTF-8" );
//
//            multipart.addBodyPart(part1);
//         
//            message.setContent(multipart);
//                    
//            /**Método para enviar a mensagem criada*/
//            Transport.send(message);
//
//            //System.out.println("Done");
//        }
//        catch( Exception e )
//        {
//            System.out.println( e.getMessage() );
//        }
//    }
    
    
}
