@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite/Cube View - Spend Analytics'
@Metadata.ignorePropagatedAnnotations: true
@Analytics.dataCategory: #CUBE
define view entity ZI_R2R_VENDOR_SPEND_BA 
  as select from ZI_R2R_INVOICE_BA as Invoice
  association [0..1] to ZI_R2R_VENDOR_BA as _Vendor
  on $projection.VendorId = _Vendor.VendorId
{
  key InvoiceId,
  Invoice.VendorId,
  
  @EndUserText.label: 'Year'
  substring(Invoice.InvoiceDate, 1, 4) as CalendarYear,
  @EndUserText.label: 'Month'
  substring(Invoice.InvoiceDate, 5, 2) as CalendarMonth,
  
  Invoice.Status,
  Invoice.Currency,
  
  _Vendor.VendorName,
  _Vendor.Country,
  _Vendor.VendorType,
  
  @EndUserText.label: 'Net Balance'
  @Semantics.amount.currencyCode: 'Currency'
  @DefaultAggregation: #SUM
  case Invoice.DcIndicator
    when 'D' then -Invoice.Amount
    else Invoice.Amount
  end as ActualSpendAmount,
  
  @EndUserText.label: 'Document Amount'
  @DefaultAggregation: #SUM
  cast( 1 as abap.int4 ) as DocumentCount,
  
  @EndUserText.label: 'Invoicing YTD amount (no debits)'
  @Semantics.amount.currencyCode: 'Currency'
  @DefaultAggregation: #SUM
  case when substring(Invoice.InvoiceDate, 1, 4) = substring($session.system_date, 1, 4)
    and Invoice.DcIndicator = 'C'
    then Invoice.Amount
    else cast( 0 as abap.curr(15,2))
  end as YtdInvoiceAmount,
  
  @EndUserText.label: 'Invoice AVG amount (no debits)'
  @Semantics.amount.currencyCode: 'Currency'
  @DefaultAggregation: #SUM
  case when substring(Invoice.InvoiceDate, 1, 4) = substring($session.system_date, 1, 4)
    and Invoice.DcIndicator = 'C'
    then cast(
      div(
        cast(Invoice.Amount as abap.dec(15,2)), 
          case when cast(substring($session.system_date, 5, 2) as abap.int4) <= 1
            then 1
            else cast(substring($session.system_date, 5, 2) as abap.int4) - 1  
          end
        ) as abap.curr(15,2)
      )
    else cast( 0 as abap.curr(15,2) )
  end as YtdMonthlyAverage,
  
  _Vendor // Make association public
}
