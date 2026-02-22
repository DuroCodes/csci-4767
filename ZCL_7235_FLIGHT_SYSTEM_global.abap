CLASS zcl_7235_flight_system DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_7235_flight_system IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    CONSTANTS c_carrier_id TYPE string VALUE 'LH'.

    DATA pass_flight  TYPE REF TO lcl_flight.
    DATA cargo_flight TYPE REF TO lcl_flight.
    DATA days_later   TYPE i.

    DATA(carrier) = lcl_carrier=>get_instance( i_carrier_id = c_carrier_id ).

    out->write( name = 'Carrier Overview'
                data = carrier->get_output( ) ).

    carrier->find_passenger_flight(
      IMPORTING
        e_flight     = pass_flight
        e_days_later = days_later
    ).

    IF pass_flight IS BOUND.
      out->write( |Found a passenger flight in { days_later } days:| ).
      out->write( pass_flight->get_output( ) ).
    ELSE.
      out->write( 'No suitable passenger flight found.' ).
    ENDIF.

    carrier->find_cargo_flight(
      IMPORTING
        e_flight     = cargo_flight
        e_days_later = days_later
    ).

    IF cargo_flight IS BOUND.
      out->write( |Found a cargo flight in { days_later } days:| ).
      out->write( cargo_flight->get_output( ) ).
    ELSE.
      out->write( 'No suitable cargo flight found.' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
