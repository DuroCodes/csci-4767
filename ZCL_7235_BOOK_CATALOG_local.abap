CLASS lcl_book DEFINITION.

  PUBLIC SECTION.

    METHODS set_attributes
      IMPORTING
        iv_title  TYPE string
        iv_author  TYPE string
        iv_pages   TYPE i.

    METHODS get_display
      RETURNING
        VALUE(rv_text) TYPE string.

    CLASS-METHODS set_counter
      IMPORTING
        iv_count TYPE i.

    CLASS-METHODS get_counter
      RETURNING
        VALUE(rv_count) TYPE i.

  PRIVATE SECTION.

    DATA title  TYPE string.
    DATA author TYPE string.
    DATA pages  TYPE i.

    CLASS-DATA book_counter TYPE i.

ENDCLASS.



CLASS lcl_book IMPLEMENTATION.

  METHOD set_attributes.
    title  = iv_title.
    author = iv_author.
    pages  = iv_pages.
  ENDMETHOD.

  METHOD get_display.
    rv_text = |{ title } by { author } ({ pages } pp.)|.
  ENDMETHOD.

  METHOD set_counter.
    book_counter = iv_count.
  ENDMETHOD.

  METHOD get_counter.
    rv_count = book_counter.
  ENDMETHOD.

ENDCLASS.
