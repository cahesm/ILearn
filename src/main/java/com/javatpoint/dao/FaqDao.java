package com.javatpoint.dao;

import com.javatpoint.model.Faq;
import com.javatpoint.model.Search;
import java.util.List;

public interface FaqDao {

  void register( Faq faq );
  void update( Faq faq );
  void delete( int idFaq );
  Faq getFaq( int idFaq );
  List<Faq> getFaqs();
  List<Faq> getFaqs( Search filter );
  
}
