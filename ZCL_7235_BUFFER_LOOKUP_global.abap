CLASS zcl_7235_buffer_lookup DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_7235_buffer_lookup IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA item TYPE REF TO lcl_catalog_item.

    item = NEW #( iv_id = 'P001' ).
    out->write( item->get_display( ) ).

    item = NEW #( iv_id = 'P002' ).
    out->write( item->get_display( ) ).

    item = NEW #( iv_id = 'P003' ).
    out->write( item->get_display( ) ).

    out->write( |Lookups done from buffer (no repeated SELECT)| ).
  ENDMETHOD.
ENDCLASS.
