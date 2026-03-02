CLASS lcl_conversion_demo DEFINITION.

  PUBLIC SECTION.

    METHODS show_successful_conversion
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_conversion_exceptions
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_truncation_and_exact
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_rounding_and_exact
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_inline_pitfall
      RETURNING
        VALUE(r_result) TYPE string_table.

ENDCLASS.



CLASS lcl_conversion_demo IMPLEMENTATION.

  METHOD show_successful_conversion.
    DATA var_string TYPE string.
    DATA var_int    TYPE i.
    DATA var_date   TYPE d.

    var_string = `12345`.
    var_int = var_string.
    APPEND |String '{ var_string }' to integer => { var_int }| TO r_result.

    var_string = `20260301`.
    var_date = var_string.
    APPEND |String '{ var_string }' to date => { var_date DATE = USER }| TO r_result.
  ENDMETHOD.

  METHOD show_conversion_exceptions.
    DATA var_string TYPE string.
    DATA var_int    TYPE i.
    DATA var_pack   TYPE p LENGTH 3 DECIMALS 2.
    DATA source_pack TYPE p LENGTH 4 DECIMALS 2.

    var_string = `ABCDE`.
    TRY.
        var_int = var_string.
      CATCH cx_sy_conversion_no_number INTO DATA(no_number).
        APPEND |Cannot convert '{ var_string }' to integer ({ no_number->get_text( ) })|
          TO r_result.
    ENDTRY.

    source_pack = '1000.00'.

    TRY.
        var_pack = source_pack.
      CATCH cx_sy_conversion_overflow INTO DATA(overflow).
        APPEND |Overflow assigning { source_pack } to P(3,2) ({ overflow->get_text( ) })|
          TO r_result.
    ENDTRY.
  ENDMETHOD.

  METHOD show_truncation_and_exact.
    DATA long_char  TYPE c LENGTH 10.
    DATA short_char TYPE c LENGTH 3.

    long_char = 'ABCDEFGHIJ'.
    short_char = long_char.
    APPEND |Implicit assignment truncates '{ long_char }' to '{ short_char }'| TO r_result.

    TRY.
        short_char = EXACT #( long_char ).
      CATCH cx_sy_conversion_error.
        APPEND 'EXACT detected truncation and raised CX_SY_CONVERSION_ERROR' TO r_result.
    ENDTRY.
  ENDMETHOD.

  METHOD show_rounding_and_exact.
    DATA var_pack TYPE p LENGTH 3 DECIMALS 2.

    var_pack = 1 / 8.
    APPEND |1/8 with P(3,2) rounds to { var_pack NUMBER = USER }| TO r_result.

    TRY.
        var_pack = EXACT #( 1 / 8 ).
      CATCH cx_sy_conversion_error.
        APPEND 'EXACT detected rounding and raised CX_SY_CONVERSION_ERROR' TO r_result.
    ENDTRY.
  ENDMETHOD.

  METHOD show_inline_pitfall.
    DATA(result_int) = 5 / 10.
    DATA(result_dec) = CONV decfloat34( 5 ) / CONV decfloat34( 10 ).

    APPEND |DATA(result_int) = 5 / 10 -> { result_int } (integer division)| TO r_result.
    APPEND |Using DECFLOAT34 -> { result_dec } (precise division)| TO r_result.
  ENDMETHOD.

ENDCLASS.
