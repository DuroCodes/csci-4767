CLASS zcl_7235_basic_data_types DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_7235_basic_data_types IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_calc,
             a        TYPE i,
             b        TYPE i,
             operator TYPE string,
           END OF ty_calc.

    DATA calculations TYPE STANDARD TABLE OF ty_calc.
    DATA result TYPE i.

    calculations = VALUE #(
     (  a = 10 b = 5 operator = '+' )
     (  a = 20 b = 4 operator = '-' )
     (  a = 6  b = 7 operator = '*' )
     (  a = 40 b = 8 operator = '/' )
    ).

    out->write( 'beep boop doing calculations:' ).
    LOOP AT calculations INTO DATA(calc).
      CASE calc-operator.
        WHEN '+'.
          result = calc-a + calc-b.
        WHEN '-'.
          result = calc-a - calc-b.
        WHEN '*'.
          result = calc-a * calc-b.
        WHEN '/'.
          IF calc-b <> 0.
            result = calc-a / calc-b.
          ELSE.
            out->write( 'Cannot divide by 0' ).
            CONTINUE.
          ENDIF.
      ENDCASE.

      out->write( |{ calc-a } { calc-operator } { calc-b } = { result }| ).
    ENDLOOP.
    out->write( 'calc is short for calculator if you''re new to the stream' ).
  ENDMETHOD.
ENDCLASS.