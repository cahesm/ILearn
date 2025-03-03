/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javatpoint.util;

import java.text.NumberFormat;
import java.util.Locale;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.util.StringUtils;

public class FormCustomNumberEditor extends CustomNumberEditor {

    public FormCustomNumberEditor(Class<? extends Number> numberClass) throws IllegalArgumentException {
        super(numberClass, true);
    }

    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        if (!StringUtils.hasText(text)) {
            setValue(0);
        }else {
            
            if ( text.contains(",") )
            {
                try
                {
                    text = text.replaceAll("\\.", "");
                    NumberFormat format = NumberFormat.getInstance(Locale.FRANCE);
                    Number number = format.parse( text );
                    setValue( number.doubleValue() );
                }
                catch( Exception e )
                {
                    setValue(0);
                }
            }
            else
            {                        
                super.setAsText(text.trim());
            }
        }
    }

}
