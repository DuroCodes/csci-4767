CLASS lcl_dictionary_cds_demo DEFINITION.

  PUBLIC SECTION.

    METHODS show_dictionary_roles
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_domain_and_element_pattern
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_client_field_pattern
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_cds_view_entity_points
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_metadata_extension_points
      RETURNING
        VALUE(r_result) TYPE string_table.

ENDCLASS.



CLASS lcl_dictionary_cds_demo IMPLEMENTATION.

  METHOD show_dictionary_roles.
    APPEND |1) Table definitions describe DB tables; Open SQL is checked against them and the DBI translates to native SQL.|
      TO r_result.
    APPEND |2) Dictionary types (data elements, structures, table types) are reusable across the system; they differ from local TYPES.|
      TO r_result.
    APPEND |3) Classical UI used dictionary metadata (F4, labels); RAP and CDS carry semantics for modern consumers instead.|
      TO r_result.
  ENDMETHOD.

  METHOD show_domain_and_element_pattern.
    TYPES ty_annual_salary TYPE p LENGTH 15 DECIMALS 2.

    DATA salary TYPE ty_annual_salary.

    salary = '123456.78'.
    APPEND |A domain in DDIC holds technical type/length (here mimicked as P length 15 decimals 2); a data element references it and adds field labels.|
      TO r_result.
    APPEND |Sample amount typed like a CURR-style packed field: { salary NUMBER = USER }|
      TO r_result.
    APPEND |For DEC/QUAN/CURR domains, prefer odd lengths to reduce half-byte packed quirks described in the course material.|
      TO r_result.
  ENDMETHOD.

  METHOD show_client_field_pattern.
    DATA client TYPE abap.clnt.

    client = sy-mandt.
    APPEND |Purely technical fields may use predefined types such as abap.clnt; business fields should reference data elements for semantics.|
      TO r_result.
    APPEND |Current client in this run: '{ client }'|
      TO r_result.
  ENDMETHOD.

  METHOD show_cds_view_entity_points.
    APPEND |Obsolete DDIC-based CDS views used DEFINE VIEW and a generated dictionary view; view entities use DEFINE VIEW ENTITY and own the DB object directly.|
      TO r_result.
    APPEND |Dictionary database views are limited and not supported in cloud ABAP; push-down logic lives in CDS SQL on the database.|
      TO r_result.
    APPEND |Associations in CDS (for example to I_Country) add related fields without manual joins in every consumer.|
      TO r_result.
    APPEND |Using a database table directly as an ABAP data type works but is discouraged; prefer explicit structure types.|
      TO r_result.
  ENDMETHOD.

  METHOD show_metadata_extension_points.
    APPEND |Metadata extensions use ANNOTATE VIEW (or ANNOTATE ENTITY) and cannot introduce new elements—only annotate existing ones.|
      TO r_result.
    APPEND |The base entity must allow extensions via @Metadata.allowExtensions: true.|
      TO r_result.
    APPEND |Each extension sets @Metadata.layer; when values clash, #CUSTOMER wins over #PARTNER, then #INDUSTRY, #LOCALIZATION, and #CORE last.|
      TO r_result.
    APPEND |RAP practice: keep core UI metadata in layer #CORE so partners and customers can override in higher layers.|
      TO r_result.
  ENDMETHOD.

ENDCLASS.
