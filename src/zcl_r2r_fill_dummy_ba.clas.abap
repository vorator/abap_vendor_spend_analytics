class zcl_r2r_fill_dummy_ba definition
  public
  final
  create public .

  public section.

    interfaces if_oo_adt_classrun .
  protected section.
  private section.
endclass.



class zcl_r2r_fill_dummy_ba implementation.


  method if_oo_adt_classrun~main.

    data: lt_invoices type table of zr2r_invoice_ba,
          lt_vendors TYPE TABLE OF zr2r_vendor_ba.

    data(currentDataTime) = cl_abap_context_info=>get_system_date( ).

    try.
      lt_vendors = VALUE #(
      ( vendor_id   = 'VD0001'
        vendor_name = 'Tech Solutions Lda'
        country     = 'PT'
        vendor_type = 'L'
        created_by  = sy-uname
        created_at  = currentDataTime )

      ( vendor_id   = 'VD0002'
        vendor_name = 'Consulting XPTO'
        country     = 'ES'
        vendor_type = 'G'
        created_by  = sy-uname
        created_at  = currentDataTime )

      ( vendor_id   = 'VD0003'
        vendor_name = 'Global Logistics'
        country     = 'US'
        vendor_type = 'G'
        created_by  = sy-uname
        created_at  = currentDataTime )
    ).

    INSERT zr2r_vendor_ba FROM TABLE @lt_vendors.

    if sy-subrc = 0.
          out->write( |Success! { lines( lt_vendors ) } VENDOR records were inserted.| ).
        else.
          out->write( 'Error inserting VENDOR data.' ).
        endif.

    catch cx_uuid_error into data(lx_uuid_vend).
        out->write( |Error generating UUID: { lx_uuid_vend->get_text( ) }| ).
    endtry.


    delete from zr2r_invoice_ba.

    try.
        lt_invoices = value #(
          ( invoice_id   = cl_system_uuid=>create_uuid_x16_static( )
            vendor_id    = 'VD0001'
            vendor_name  = 'Tech Solutions Lda'
            amount       = '15000.00'
            currency     = 'EUR'
            invoice_date = '20260115'
            dc_indicator = 'C' " Credit / Invoice
            status       = 'A'
            description  = 'SAP Licenses'
            created_by   = sy-uname
            created_at   = currentDataTime )

          ( invoice_id   = cl_system_uuid=>create_uuid_x16_static( )
            vendor_id    = 'VD0001'
            vendor_name  = 'Tech Solutions Lda'
            amount       = '2500.00'
            currency     = 'EUR'
            invoice_date = '20260220'
            dc_indicator = 'D' " Debit / Credit-note
            status       = 'A'
            description  = 'Invoice correction - Downgrade'
            created_by   = sy-uname
            created_at   = currentDataTime )

          ( invoice_id   = cl_system_uuid=>create_uuid_x16_static( )
            vendor_id    = 'VD0002'
            vendor_name  = 'Consulting XPTO'
            amount       = '8500.50'
            currency     = 'EUR'
            invoice_date = '20260310'
            dc_indicator = 'C' " Credit / Invoice
            status       = 'P'
            description  = 'Consulting services R2R'
            created_by   = sy-uname
            created_at   = currentDataTime )

          ( invoice_id   = cl_system_uuid=>create_uuid_x16_static( )
            vendor_id    = 'VD0003'
            vendor_name  = 'Global Logistics'
            amount       = '20000.00'
            currency     = 'USD'
            invoice_date = '20260505'
            dc_indicator = 'C' " Credit / Invoice
            status       = 'A'
            description  = 'Transport Internacional'
            created_by   = sy-uname
            created_at   = currentDataTime )
        ).

        insert zr2r_invoice_ba from table @lt_invoices.

        if sy-subrc = 0.
          out->write( |Success! { lines( lt_invoices ) } INVOICE records were inserted.| ).
        else.
          out->write( 'Error inserting INVOICE data.' ).
        endif.

      catch cx_uuid_error into data(lx_uuid_inv).
        out->write( |Error generating UUID: { lx_uuid_inv->get_text( ) }| ).
    endtry.

  endmethod.
endclass.
