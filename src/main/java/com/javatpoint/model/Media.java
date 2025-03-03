/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javatpoint.model;

import java.sql.Timestamp;

/**
 *
 * @author usuario
 */
public class Media {
    
    public final static int TYPE_HOTEL_IMAGE = 0;
    public final static int TYPE_UNIT_IMAGE = 1;
    public final static int TYPE_UNIT_DOCUMENT = 2;
    public final static int TYPE_RESERVATION_PAYMENT = 3;
    public final static int TYPE_RESERVATION_VOUCHER = 4;
    public final static int TYPE_RESERVATION_DOC = 5;
    public final static int TYPE_USER_DOCUMENT = 6;
    
    public final static int STATUS_CREATED = 0;
    public final static int STATUS_PENDING_APPROVAL = 1;
    public final static int STATUS_APPROVED = 2;
    public final static int STATUS_REPROVED = 3;
    
    private int idMedia;
    private int idSource;
    private int type;
    private int status;
    private String name;
    private String alias;
    private String comment;
    private Timestamp creation;
    
    /**
     * @return int
     */
    public int getIdMedia()
    {
        return idMedia;
    }
    
    /**
     * @param idMedia int
     */
    public void setIdMedia( int value )
    {
        this.idMedia = value;
    }
    
    /**
     * @return int
     */
    public int getIdSource()
    {
        return idSource;
    }
    
    /**
     * @param idSource int
     */
    public void setIdSource( int value )
    {
        this.idSource = value;
    }
    
    /**
     * @return int
     */
    public int getType()
    {
        return type;
    }
    
    /**
     * @param type int
     */
    public void setType( int value )
    {
        this.type = value;
    }
    
    
    /**
     * @return int
     */
    public int getStatus()
    {
        return status;
    }
    
    /**
     * @param status int
     */
    public void setStatus( int value )
    {
        this.status = value;
    }
    
    
    /**
     * @return String
     */
    public String getName()
    {
        return name;
    }
    
    /**
     * @param name String
     */
    public void setName( String value )
    {
        this.name = value;
    }
    
    
    /**
     * @return String
     */
    public String getAlias()
    {
        return alias;
    }
    
    /**
     * @param alias String
     */
    public void setAlias( String value )
    {
        this.alias = value;
    }
    
    
    /**
     * @return String
     */
    public String getComment()
    {
        return comment;
    }
    
    /**
     * @param comment String
     */
    public void setComment( String value )
    {
        this.comment = value;
    }
         
    
    /**
     * @return Timestamp
     */
    public Timestamp getCreation()
    {
        return creation;
    }
    
    /**
     * @param creation Timestamp
     */
    public void setCreation( Timestamp value )
    {
        this.creation = value;
    }
        
    @Override
    public int hashCode() 
    {
        return idMedia;
    }

    @Override
    public boolean equals(Object obj) 
    {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Media d = (Media) obj;
        return idMedia == d.idMedia;
    }
       
}
