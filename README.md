# SAP ABAP RAP: Vendor Invoice Analytics (Clean Core VDM)

An advanced analytical application built on SAP S/4HANA using the ABAP RESTful Application Programming Model (RAP) and Virtual Data Model (VDM) architecture. This project demonstrates the implementation of the "Code-to-Data" paradigm by pushing down heavy financial aggregations directly to the SAP HANA database.

## 🎯 Business Use Case
In modern Record-to-Report (R2R) and Accounts Payable (AP) operations, financial controllers require real-time visibility into vendor spend and exposure. Instead of extracting data to external BI tools, this solution provides an embedded, real-time analytical dashboard. 

**Key business capabilities:**
* **Net Spend Calculation:** Automatically deducts Credit Notes (Debit adjustments) from standard Invoices at the database level to show the true financial balance.
* **YTD Exposure & Averages:** Dynamically calculates Year-to-Date (YTD) billing and strictly computes the monthly average spend based on the current system date, aiding in cash-flow forecasting and compliance monitoring.

## 🏗️ Technical Architecture (Clean Core)
This solution strictly adheres to SAP's Clean Core principles by implementing a highly decoupled 3-layer Virtual Data Model (VDM):
* **Basic / Interface Layer (lv1):** Provides foundational access to the underlying physical transparent tables, establishing semantics and primary associations.
* **Composite / Cube Layer (lv2):** Acts as the analytical engine (`@Analytics.dataCategory: #CUBE`). It handles the core business logic, including conditional aggregations (`CASE` statements for D/C indicators) and mathematical operations (`div` for monthly averages) using HANA push-down capabilities.
* **Consumption / Query Layer (lv3):** Implemented as a `transient view entity` using the highly restrictive `provider contract analytical_query`. It defines the multidimensional layout, UI chart annotations, and metrics exposure for the Fiori frontend, completely omitting the document keys to enforce OLAP aggregation.

## 📸 Showcase

### 1. Analytic Elements UI
<img width="1917" height="898" alt="image" src="https://github.com/user-attachments/assets/8e6342b0-0e4d-4c9f-8045-d0629e0e54fe" />

<img width="1919" height="561" alt="image" src="https://github.com/user-attachments/assets/c873325d-2a10-49a4-8dfa-c333e0a2ed7e" />

### 2. Business Logic Implementation (Eclipse ADT)
<img width="1916" height="1050" alt="image" src="https://github.com/user-attachments/assets/2bc221d4-29ca-4c45-aee3-f4157045891e" />

## 🛠️ Key Features Implemented
- [x] **Code-to-Data Paradigm:** Elimination of ABAP application-server processing (no `LOOP` or `COLLECT`). All mathematical operations are executed by the HANA database.
- [x] **Advanced ABAP SQL:** Usage of string manipulation (`substring`), system variables (`$session.system_date`), and division logic (`div` / `division`) directly within CDS views.
- [x] **Modern Protocol Exposure:** Service bindings configured for **InA (Information Access)** protocol to support native, high-performance multidimensional analysis in SAP Fiori Data Analyzer (SAC compatible).
- [x] **Strict ABAP Cloud Compliance:** Usage of `transient view entity` and `provider contract analytical_query` to comply with the latest SAP S/4HANA release guidelines.

## 👨‍💻 About the Developer
I am an IT Engineer and Software Developer specializing in SAP ABAP, S/4HANA architecture, and Java. 
With a robust background integrating cross-border financial systems and ERPs (SAP, Navision, SAGE), I build resilient technical solutions grounded in deep business process understanding.
[🔗 Connect with me on LinkedIn](https://linkedin.com/in/luispinto82/) | 💻 **GitHub:** [@vorator](https://github.com/vorator)







