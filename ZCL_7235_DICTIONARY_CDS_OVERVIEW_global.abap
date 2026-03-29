CLASS zcl_7235_dictionary_cds_overview DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_7235_dictionary_cds_overview IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA demo TYPE REF TO lcl_dictionary_cds_demo.

    demo = NEW #( ).

    out->write( name = 'ABAP Dictionary roles'
                data = demo->show_dictionary_roles( ) ).

    out->write( name = 'Domain vs data element (ABAP side)'
                data = demo->show_domain_and_element_pattern( ) ).

    out->write( name = 'Technical client field pattern'
                data = demo->show_client_field_pattern( ) ).

    out->write( name = 'CDS view entities and modernization'
                data = demo->show_cds_view_entity_points( ) ).

    out->write( name = 'Metadata extensions'
                data = demo->show_metadata_extension_points( ) ).
  ENDMETHOD.
ENDCLASS.
