CLASS zcl_7235_conversion_safety DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_7235_conversion_safety IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA demo TYPE REF TO lcl_conversion_demo.

    demo = NEW #( ).

    out->write( name = 'Successful Conversion'
                data = demo->show_successful_conversion( ) ).

    out->write( name = 'Conversion Exceptions'
                data = demo->show_conversion_exceptions( ) ).

    out->write( name = 'Truncation and EXACT'
                data = demo->show_truncation_and_exact( ) ).

    out->write( name = 'Rounding and EXACT'
                data = demo->show_rounding_and_exact( ) ).

    out->write( name = 'Inline Declaration Pitfall'
                data = demo->show_inline_pitfall( ) ).
  ENDMETHOD.
ENDCLASS.
