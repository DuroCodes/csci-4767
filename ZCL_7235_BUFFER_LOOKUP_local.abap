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
