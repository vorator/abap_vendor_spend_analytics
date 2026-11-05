@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View - Invoices R2R'
@Metadata.ignorePropagatedAnnotations: false
define view entity ZI_R2R_INVOICE_BA as select from ZR2R_INVOICE_BA
{
  key invoice_id  as InvoiceId,
  vendor_id       as VendorId,
  vendor_name     as VendorName,
  amount          as Amount,
  currency        as Currency,
  invoice_date    as InvoiceDate,
  dc_indicator    as DcIndicator,
  status          as Status,
  description     as Description,
  @Semantics.user.createdBy: true
  created_by      as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at      as CreatedAt,
  @Semantics.user.lastChangedBy: true
  modified_by     as ModifiedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  modified_at     as ModifiedAt
}
