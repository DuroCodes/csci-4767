* In ADT this class has two tabs. Do NOT paste the whole file into one tab.
* Global Class tab: paste from ZCL_7235_BOOK_CATALOG_global.abap
* Local Types tab:  paste from ZCL_7235_BOOK_CATALOG_local.abap
*
CLASS zcl_7235_book_catalog DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_7235_book_catalog IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA book TYPE REF TO lcl_book.
    DATA catalog TYPE TABLE OF REF TO lcl_book.

    book = NEW #( ).
    book->set_attributes(
      iv_title  = 'The Pragmatic Programmer'
      iv_author = 'Hunt & Thomas'
      iv_pages  = 352 ).
    APPEND book TO catalog.

    book = NEW #( ).
    book->set_attributes(
      iv_title  = 'Clean Code'
      iv_author = 'Robert C. Martin'
      iv_pages  = 464 ).
    APPEND book TO catalog.

    book = NEW #( ).
    book->set_attributes(
      iv_title  = 'Designing Data-Intensive Applications'
      iv_author = 'Martin Kleppmann'
      iv_pages  = 616 ).
    APPEND book TO catalog.

    lcl_book=>set_counter( lines( catalog ) ).

    out->write( 'Book catalog' ).
    out->write( '------------' ).
    LOOP AT catalog INTO book.
      out->write( book->get_display( ) ).
    ENDLOOP.
    out->write( |Total: { lcl_book=>get_counter( ) } books| ).
  ENDMETHOD.
ENDCLASS.



*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

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
