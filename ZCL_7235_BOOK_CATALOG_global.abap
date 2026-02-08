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
