extend view entity ZRAP630C_ShopTP_05A with {
//    base_data_source_name.element_name
  @UI.lineItem: [ {
    position: 140 , 
    importance: #MEDIUM, 
    label: 'Feedback'
    }, { type: #FOR_ACTION, dataAction: 'ZZ_ProvideFeedback', label: 'Update feedback' }  ]
    @UI.identification: [ {
    position: 140 , 
    label: 'Feedback 13'
    } ]
  
  
  
   Shop.zz_feedback_zaa as zz_feedback_zaa  
}

