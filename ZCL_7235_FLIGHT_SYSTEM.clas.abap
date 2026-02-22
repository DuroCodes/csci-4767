* In ADT this class has two tabs. Do NOT paste the whole file into one tab.
* Global Class tab: paste from ZCL_7235_FLIGHT_SYSTEM_global.abap
* Local Types tab:  paste from ZCL_7235_FLIGHT_SYSTEM_local.abap
*
* Demonstrates: abstract classes, inheritance, singleton factory method,
* and ABAP Doc documentation.
*
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



*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type declarations


"! Abstract superclass for classes
"! {@link .lcl_passenger_flight} and
"! {@link .lcl_cargo_flight}. <br/>
"! Every instance is uniquely identified by attributes
"! {@link .lcl_flight.DATA:carrier_id },
"! {@link .lcl_flight.DATA:connection_id }, and
"! {@link .lcl_flight.DATA:flight_date }.
CLASS lcl_flight DEFINITION ABSTRACT.

  PUBLIC SECTION.

    TYPES tab TYPE STANDARD TABLE OF REF TO lcl_flight WITH DEFAULT KEY.

    DATA carrier_id    TYPE string READ-ONLY.
    DATA connection_id TYPE string READ-ONLY.
    DATA flight_date   TYPE d      READ-ONLY.

    METHODS constructor
      IMPORTING
        iv_carrier_id    TYPE string
        iv_connection_id TYPE string
        iv_flight_date   TYPE d.

    METHODS get_output ABSTRACT
      RETURNING
        VALUE(r_result) TYPE string_table.

ENDCLASS.


CLASS lcl_flight IMPLEMENTATION.

  METHOD constructor.
    carrier_id    = iv_carrier_id.
    connection_id = iv_connection_id.
    flight_date   = iv_flight_date.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_passenger_flight DEFINITION INHERITING FROM lcl_flight.

  PUBLIC SECTION.

    TYPES tt_flights TYPE STANDARD TABLE OF REF TO lcl_passenger_flight WITH DEFAULT KEY.

    DATA seats_occupied TYPE i READ-ONLY.
    DATA seats_max      TYPE i READ-ONLY.

    METHODS constructor
      IMPORTING
        iv_carrier_id    TYPE string
        iv_connection_id TYPE string
        iv_flight_date   TYPE d
        iv_seats_max     TYPE i
        iv_seats_occ     TYPE i.

    METHODS get_free_seats
      RETURNING
        VALUE(rv_seats) TYPE i.

    CLASS-METHODS get_flights_by_carrier
      IMPORTING
        i_carrier_id    TYPE string
      RETURNING
        VALUE(r_result) TYPE tt_flights.

    METHODS get_output REDEFINITION.

ENDCLASS.


CLASS lcl_passenger_flight IMPLEMENTATION.

  METHOD constructor.
    super->constructor(
      iv_carrier_id    = iv_carrier_id
      iv_connection_id = iv_connection_id
      iv_flight_date   = iv_flight_date ).
    seats_max      = iv_seats_max.
    seats_occupied = iv_seats_occ.
  ENDMETHOD.

  METHOD get_free_seats.
    rv_seats = seats_max - seats_occupied.
  ENDMETHOD.

  METHOD get_flights_by_carrier.
    r_result = VALUE #(
      ( NEW lcl_passenger_flight(
          iv_carrier_id    = i_carrier_id
          iv_connection_id = '0400'
          iv_flight_date   = '20260301'
          iv_seats_max     = 220
          iv_seats_occ     = 180 ) )
      ( NEW lcl_passenger_flight(
          iv_carrier_id    = i_carrier_id
          iv_connection_id = '0401'
          iv_flight_date   = '20260302'
          iv_seats_max     = 180
          iv_seats_occ     = 90 ) )
    ).
  ENDMETHOD.

  METHOD get_output.
    APPEND |Carrier: { carrier_id } \| Connection: { connection_id }| TO r_result.
    APPEND |Date: { flight_date DATE = USER }| TO r_result.
    APPEND |Seats: { seats_occupied }/{ seats_max } (Free: { get_free_seats( ) })|
      TO r_result.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_cargo_flight DEFINITION INHERITING FROM lcl_flight.

  PUBLIC SECTION.

    TYPES tt_flights  TYPE STANDARD TABLE OF REF TO lcl_cargo_flight WITH DEFAULT KEY.
    TYPES ty_capacity TYPE p LENGTH 7 DECIMALS 2.

    DATA cargo_actual TYPE ty_capacity READ-ONLY.
    DATA cargo_max    TYPE ty_capacity READ-ONLY.

    METHODS constructor
      IMPORTING
        iv_carrier_id    TYPE string
        iv_connection_id TYPE string
        iv_flight_date   TYPE d
        iv_cargo_max     TYPE ty_capacity
        iv_cargo_actual  TYPE ty_capacity.

    METHODS get_free_capacity
      RETURNING
        VALUE(rv_capacity) TYPE ty_capacity.

    CLASS-METHODS get_flights_by_carrier
      IMPORTING
        i_carrier_id    TYPE string
      RETURNING
        VALUE(r_result) TYPE tt_flights.

    METHODS get_output REDEFINITION.

ENDCLASS.


CLASS lcl_cargo_flight IMPLEMENTATION.

  METHOD constructor.
    super->constructor(
      iv_carrier_id    = iv_carrier_id
      iv_connection_id = iv_connection_id
      iv_flight_date   = iv_flight_date ).
    cargo_max    = iv_cargo_max.
    cargo_actual = iv_cargo_actual.
  ENDMETHOD.

  METHOD get_free_capacity.
    rv_capacity = cargo_max - cargo_actual.
  ENDMETHOD.

  METHOD get_flights_by_carrier.
    r_result = VALUE #(
      ( NEW lcl_cargo_flight(
          iv_carrier_id    = i_carrier_id
          iv_connection_id = '8001'
          iv_flight_date   = '20260301'
          iv_cargo_max     = '80000'
          iv_cargo_actual  = '62000' ) )
      ( NEW lcl_cargo_flight(
          iv_carrier_id    = i_carrier_id
          iv_connection_id = '8002'
          iv_flight_date   = '20260303'
          iv_cargo_max     = '60000'
          iv_cargo_actual  = '10000' ) )
    ).
  ENDMETHOD.

  METHOD get_output.
    APPEND |Carrier: { carrier_id } \| Connection: { connection_id }| TO r_result.
    APPEND |Date: { flight_date DATE = USER }| TO r_result.
    APPEND |Cargo: { cargo_actual }/{ cargo_max } kg (Free: { get_free_capacity( ) } kg)|
      TO r_result.
  ENDMETHOD.

ENDCLASS.


"! <p class="shorttext synchronized">Flight Carrier</p>
"! Flight Carrier - A factory logic ensures that there is only
"! one instance for the same carrier ID. <br/>
"! Use {@link .lcl_carrier.METH:get_instance} to obtain an instance.
CLASS lcl_carrier DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.

    TYPES: tt_carriers TYPE STANDARD TABLE OF REF TO lcl_carrier
                       WITH DEFAULT KEY.

    "! Factory method - returns an instance of this class.
    "! @parameter i_carrier_id | Three-character identification of the carrier.
    "! @parameter r_result     | Reference to the instance.
    CLASS-METHODS get_instance
      IMPORTING
        i_carrier_id    TYPE string
      RETURNING
        VALUE(r_result) TYPE REF TO lcl_carrier.

    METHODS get_output
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS find_passenger_flight
      IMPORTING
        i_min_free_seats TYPE i DEFAULT 1
      EXPORTING
        e_flight         TYPE REF TO lcl_flight
        e_days_later     TYPE i.

    METHODS find_cargo_flight
      IMPORTING
        i_min_free_capacity TYPE lcl_cargo_flight=>ty_capacity DEFAULT 1
      EXPORTING
        e_flight            TYPE REF TO lcl_flight
        e_days_later        TYPE i.

  PRIVATE SECTION.

    CLASS-DATA instances TYPE tt_carriers.

    DATA carrier_id TYPE string.
    DATA name       TYPE string.
    DATA flights    TYPE lcl_flight=>tab.
    DATA pf_count   TYPE i.
    DATA cf_count   TYPE i.

    METHODS constructor
      IMPORTING
        i_carrier_id TYPE string.

ENDCLASS.


CLASS lcl_carrier IMPLEMENTATION.

  METHOD get_instance.
    TRY.
        r_result = instances[ table_line->carrier_id = i_carrier_id ].
      CATCH cx_sy_itab_line_not_found.
        r_result = NEW #( i_carrier_id = i_carrier_id ).
        APPEND r_result TO instances.
    ENDTRY.
  ENDMETHOD.

  METHOD constructor.
    carrier_id = i_carrier_id.

    CASE i_carrier_id.
      WHEN 'LH'. name = 'Lufthansa'.
      WHEN 'AA'. name = 'American Airlines'.
      WHEN 'UA'. name = 'United Airlines'.
      WHEN OTHERS. name = |Unknown Carrier ({ i_carrier_id })|.
    ENDCASE.

    DATA(passenger_flights) = lcl_passenger_flight=>get_flights_by_carrier(
                                  i_carrier_id = i_carrier_id ).
    pf_count = lines( passenger_flights ).

    DATA(cargo_flights) = lcl_cargo_flight=>get_flights_by_carrier(
                              i_carrier_id = i_carrier_id ).
    cf_count = lines( cargo_flights ).

    flights = VALUE #( BASE flights
                       FOR pf IN passenger_flights ( pf ) ).
    flights = VALUE #( BASE flights
                       FOR cf IN cargo_flights ( cf ) ).
  ENDMETHOD.

  METHOD get_output.
    APPEND |Carrier:           { name }| TO r_result.
    APPEND |Passenger Flights: { pf_count }| TO r_result.
    APPEND |Cargo Flights:     { cf_count }| TO r_result.
  ENDMETHOD.

  METHOD find_passenger_flight.
    CLEAR e_flight.
    e_days_later = 0.

    LOOP AT flights INTO DATA(flight)
      WHERE table_line IS INSTANCE OF lcl_passenger_flight.
      DATA(pf) = CAST lcl_passenger_flight( flight ).
      IF pf->get_free_seats( ) >= i_min_free_seats.
        e_flight     = flight.
        e_days_later = pf->flight_date - sy-datum.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD find_cargo_flight.
    CLEAR e_flight.
    e_days_later = 0.

    LOOP AT flights INTO DATA(flight)
      WHERE table_line IS INSTANCE OF lcl_cargo_flight.
      DATA(cf) = CAST lcl_cargo_flight( flight ).
      IF cf->get_free_capacity( ) >= i_min_free_capacity.
        e_flight     = flight.
        e_days_later = cf->flight_date - sy-datum.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
