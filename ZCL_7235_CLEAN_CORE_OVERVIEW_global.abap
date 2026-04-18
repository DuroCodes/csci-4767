CLASS zcl_7235_clean_core_overview DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_7235_clean_core_overview IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA demo TYPE REF TO lcl_clean_core_demo.

    demo = NEW #( ).

    out->write( name = 'Software scope types'
                data = demo->show_scope_types( ) ).

    out->write( name = 'Classic extensibility layers'
                data = demo->show_classic_layers( ) ).

    out->write( name = 'Clean core principles'
                data = demo->show_clean_core_principles( ) ).

    out->write( name = 'Migration workstreams'
                data = demo->show_workstreams_and_tools( ) ).

    out->write( name = 'Modifications and review focus'
                data = demo->show_modification_review( ) ).

    out->write( name = 'Transition approaches'
                data = demo->show_transition_choices( ) ).
  ENDMETHOD.
ENDCLASS.
