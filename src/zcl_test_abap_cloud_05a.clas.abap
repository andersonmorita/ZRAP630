CLASS zcl_test_abap_cloud_05a DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS main.
ENDCLASS.



CLASS ZCL_TEST_ABAP_CLOUD_05A IMPLEMENTATION.


  METHOD main.
*    CALL FUNCTION 'POPUP_TO_CONFIRM'.
*
*    SELECT SINGLE * FROM bnka WHERE banks = 'DE' INTO @DATA(bank_info).
*
*    DATA bank_address  TYPE bapi1011_address.
*    DATA bank_ctry  TYPE banks  .
*
*    CALL FUNCTION 'BAPI_BANK_CREATE'
*      EXPORTING
*        bank_ctry    = bank_ctry
**       bank_key     =
*        bank_address = bank_address
**       bank_method  =
**       bank_formatting              =
**       bank_address1                =
**       i_xupdate    = 'X'
**       i_check_before_save          =
**       bank_iban_rule               =
**       bank_b2b_supported           =
**       bank_cor1_supported          =
**       bank_r_transaction_supported =
**       bank_internal_bank           =
**       i_no_overwrite               =
**  IMPORTING
**       return       =
**       bankcountry  =
**       bankkey      =
*      .
*
*    SELECT * FROM I_Bank_2
*    WHERE BankCountry = 'DE'
*    INTO TABLE @DATA(bank_data_from_bnka).
*
*
*


 DATA create_bank TYPE STRUCTURE FOR CREATE i_banktp.
 DATA bank_id_number TYPE i_banktp-BankInternalID VALUE '8888'.

 create_bank = VALUE #( bankcountry = 'CZ'
                      bankinternalid = bank_id_number
                      longbankname = 'Bank name'
                      longbankbranch = 'Bank branch'
                      banknumber = bank_id_number
                      bankcategory = ''
                      banknetworkgrouping = ''
                      swiftcode = 'SABMGB2LACP'
                      ismarkedfordeletion = ''
               ).



 MODIFY ENTITIES OF i_banktp
 ENTITY bank
 CREATE FIELDS ( bankcountry
               bankinternalid
               longbankname
               longbankbranch
               banknumber
               bankcategory
               banknetworkgrouping
               swiftcode
               IsMarkedForDeletion
            )
  WITH VALUE #( (
  %cid = 'cid1'
    bankcountry         = create_bank-bankcountry
    bankinternalid      = create_bank-bankinternalid
    longbankname        = create_bank-longbankname
    longbankbranch      = create_bank-longbankbranch
    banknumber          = create_bank-banknumber
    bankcategory        = create_bank-bankcategory
    banknetworkgrouping = create_bank-banknetworkgrouping
    SWIFTCode           = create_bank-SWIFTCode
    IsMarkedForDeletion = create_bank-IsMarkedForDeletion
    )  )

  MAPPED DATA(mapped)
  REPORTED DATA(reported)
  FAILED DATA(failed).

 LOOP AT reported-bank INTO DATA(reported_error_1).
 DATA(exc_create_bank) = cl_message_helper=>get_longtext_for_message(
   EXPORTING
     text               = reported_error_1-%msg
   ).
*   out->write( |error { exc_create_bank } |  ).
 ENDLOOP.


 COMMIT ENTITIES
 RESPONSE OF i_banktp
 FAILED DATA(failed_commit)
 REPORTED DATA(reported_commit).



 LOOP AT reported_commit-bank INTO DATA(reported_error_2).
 DATA(exc_create_bank2) = cl_message_helper=>get_longtext_for_message(
   EXPORTING
     text               = reported_error_2-%msg
 ).
* out->write( |error { exc_create_bank2 } |  ).
 ENDLOOP.
 IF reported_commit-bank IS INITIAL.
 COMMIT WORK.

* SELECT SINGLE * FROM I_Bank_2 WHERE BankInternalID = @bank_id_number INTO @DATA(my_bank). "AM-29/01
* out->write( |my new bank { my_bank-BankName } { my_bank-BankInternalID }| ).
  SELECT SINGLE * FROM I_Bank_2
  WITH PRIVILEGED ACCESS
  WHERE BankInternalID = @bank_id_number INTO @DATA(my_bank).

 ENDIF.

  ENDMETHOD.


  method IF_OO_ADT_CLASSRUN~MAIN.
  endmethod.
ENDCLASS.
