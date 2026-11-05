@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Analytic Panel for vendors'
@Metadata.ignorePropagatedAnnotations: false

@UI.chart: [{
  qualifier: 'SpendChart',
  chartType: #COLUMN,
  dimensions: [ 'VendorName' ],
  measures: [ 'YtdInvoiceAmount', 'YtdMonthlyAverage' ],
  description: 'Faturação Anual vs Média Mensal'
}]

define transient view entity ZC_R2R_SPEND_ANA 
  provider contract analytical_query
  as projection on ZI_R2R_VENDOR_SPEND_BA
{
  @UI.selectionField: [{ position: 10 }]
  @UI.lineItem: [{ position: 10 }]
  VendorId,
  
  @UI.lineItem: [{ position: 20 }]
  VendorName,
  
  @UI.selectionField: [{ position: 20 }]
  @UI.lineItem: [{ position: 30 }]
  CalendarYear,
  
  @UI.selectionField: [{ position: 30 }]
  Country,
  
  CalendarMonth,
  VendorType,
  Currency,
  
  @UI.lineItem: [{ position: 40, label: 'Saldo Efetivo' }]
  ActualSpendAmount,

  @UI.lineItem: [{ position: 50, label: 'Faturação (Ano Atual)' }]
  YtdInvoiceAmount,

  @UI.lineItem: [{ position: 60, label: 'Média Mensal (Ano Atual)' }]
  YtdMonthlyAverage,

  @UI.lineItem: [{ position: 70, label: 'Nº Documentos' }]
  DocumentCount
}
