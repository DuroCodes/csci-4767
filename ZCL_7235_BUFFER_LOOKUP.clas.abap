* In ADT: paste Global Class tab from ZCL_7235_BUFFER_LOOKUP_global.abap
*          paste Local Types tab from ZCL_7235_BUFFER_LOOKUP_local.abap
*
* Demonstrates SQL Trace lesson: buffer a small "table" in a static attribute,
* fill it once in class_constructor, and read from buffer instead of SELECT SINGLE.
* Uses mock data here; replace with SELECT FROM your_table INTO TABLE @buffer if needed.
*
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



*"* Local types: buffer pattern from SQL Trace lesson

CLASS lcl_catalog_item DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS class_constructor.

    METHODS constructor
      IMPORTING
        iv_id TYPE string.

    METHODS get_display
      RETURNING
        VALUE(rv_text) TYPE string.

  PRIVATE SECTION.

    TYPES:
      BEGIN OF st_item_detail,
        name  TYPE string,
        price TYPE p LENGTH 7 DECIMALS 2,
      END OF st_item_detail,

      BEGIN OF st_catalog_buffer,
        id    TYPE string,
        name  TYPE string,
        price TYPE p LENGTH 7 DECIMALS 2,
      END OF st_catalog_buffer.

    DATA item_id   TYPE string.
    DATA item_detail TYPE st_item_detail.

    CLASS-DATA catalog_buffer TYPE TABLE OF st_catalog_buffer.

ENDCLASS.



CLASS lcl_catalog_item IMPLEMENTATION.

  METHOD class_constructor.
    " Buffer filled once (instead of repeated SELECT SINGLE per instance).
    " In a real scenario: SELECT FROM your_table INTO TABLE catalog_buffer.
    catalog_buffer = VALUE #(
      ( id = 'P001' name = 'Widget A'    price = '19.99' )
      ( id = 'P002' name = 'Widget B'    price = '29.50' )
      ( id = 'P003' name = 'Gadget X'    price = '99.00' )
    ).
  ENDMETHOD.

  METHOD constructor.
    item_id = iv_id.
    " Read from buffer instead of SELECT SINGLE (lesson pattern).
    item_detail = CORRESPONDING #( catalog_buffer[ id = iv_id ] ).
  ENDMETHOD.

  METHOD get_display.
    rv_text = |{ item_id }: { item_detail-name } - { item_detail-price }|.
  ENDMETHOD.

ENDCLASS.
