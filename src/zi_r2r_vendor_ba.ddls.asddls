@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View - Vendors'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_R2R_VENDOR_BA as select from zr2r_vendor_ba
{
  key vendor_id as VendorId,
  vendor_name   as VendorName,
  country       as Country,
  vendor_type   as VendorType,
  created_by    as CreatedBy,
  created_at    as CreatedAt,
  modified_by   as ModifiedBy,
  modified_at   as ModifiedAt
}
