CLASS lcl_clean_core_demo DEFINITION.

  PUBLIC SECTION.

    METHODS show_scope_types
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_classic_layers
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_clean_core_principles
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_workstreams_and_tools
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_modification_review
      RETURNING
        VALUE(r_result) TYPE string_table.

    METHODS show_transition_choices
      RETURNING
        VALUE(r_result) TYPE string_table.

ENDCLASS.



CLASS lcl_clean_core_demo IMPLEMENTATION.

  METHOD show_scope_types.
    APPEND |Delivered scope is the standard outcome and process coverage SAP ships in the product.| TO r_result.
    APPEND |Required scope captures what the customer must have for business execution.| TO r_result.
    APPEND |Differentiating scope covers the unique capabilities that make one organization operate differently from another.| TO r_result.
  ENDMETHOD.

  METHOD show_classic_layers.
    APPEND |Data layer: table appends extend SAP tables with customer-specific fields.| TO r_result.
    APPEND |Middle layer: code exits implement the read, update, and calculation logic in ABAP.| TO r_result.
    APPEND |Visual layer: screen exits and menu exits expose the extension to end users.| TO r_result.
    APPEND |If no suitable exit exists, customers historically used modifications or copied SAP objects.| TO r_result.
  ENDMETHOD.

  METHOD show_clean_core_principles.
    APPEND |Extensions stay strictly separate from the SAP application baseline.| TO r_result.
    APPEND |Business objects are accessed only through released, upgrade-stable APIs.| TO r_result.
    APPEND |A zero-modification mindset reduces upgrade risk and supports cloud compliance.| TO r_result.
    APPEND |Redundant enhancements and copies of SAP objects should be eliminated instead of carried forward.| TO r_result.
  ENDMETHOD.

  METHOD show_workstreams_and_tools.
    APPEND |Evaluate: collect usage data with ABAP Call Monitor or UPL, then analyze with the Custom Code Migration app.| TO r_result.
    APPEND |Adapt: use Quick Fix in ABAP development tools for Eclipse when automatic adaptation is possible.| TO r_result.
    APPEND |Review: inspect legacy modifications, copies, and implicit enhancements to remove obsolete code.| TO r_result.
    APPEND |Optimize: tune retained code with SQL Monitor, SQL Trace, and other ABAP performance tools.| TO r_result.
  ENDMETHOD.

  METHOD show_modification_review.
    APPEND |Indirect modifications include clones of SAP objects, implicit enhancements, and class-method overwrites.| TO r_result.
    APPEND |Review work should treat old modifications as candidates for elimination unless they are truly still required.| TO r_result.
    APPEND |Typical outcomes are obsolete, unused, irrelevant, or replaceable by key user or other clean-core extensibility options.| TO r_result.
  ENDMETHOD.

  METHOD show_transition_choices.
    APPEND |System conversion (Brownfield) starts from the existing ERP system and aims to get the core clean.| TO r_result.
    APPEND |New implementation (Greenfield) inherits no legacy custom code and starts with a clean core by default.| TO r_result.
    APPEND |Landscape transformation supports selective data transition from multiple ERP systems into one target landscape.| TO r_result.
    APPEND |Whichever path is chosen, custom code still needs evaluation, adaptation, review, and optimization.| TO r_result.
  ENDMETHOD.

ENDCLASS.
