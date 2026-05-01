# Data-Warehouse
Building a modern data warehouse with SQL server, including ETL processes, data modeling and analytics.

---

## Project Overview

This project includes:

- **Data Architecture**: Designing a modern data warehouse using Medallion Architecture  
- **ETL Pipelines**: Extracting, transforming, and loading data into the warehouse  
- **Data Modeling**: Building fact and dimension tables optimized for analytics 
---

## 🏗️ Data Architecture

The data architecture for this project follows the **Medallion Architecture** pattern with Bronze, Silver, and Gold layers.

![Data Architecture](./docs/Data Architecutre Design.svg)

### Bronze Layer
- Stores raw data as-is from source systems  
- Data is ingested from CSV files into a SQL Server database  

### Silver Layer
- Performs data cleansing, standardization, and normalization  
- Prepares clean and structured data for analysis  

### Gold Layer
- Contains business-ready data  
- Modeled using a **star schema** for reporting and analytics  

---


## 🎯 Skills Demonstrated

- SQL Development  
- Data Architecture  
- Data Engineering  
- ETL Pipeline Development  
- Data Modeling  
- Data Analytics  

---
