# Blinkit Data Analysis - Technical Documentation

## 📚 Data Dictionary

### Dataset Overview
- **File Name:** BlinkIT Grocery Data.csv
- **Total Records:** 11,915 transactions
- **Data Period:** 2022-2024
- **Format:** CSV

---

## 📋 Field Descriptions

| Field Name | Data Type | Description |
|------------|-----------|-------------|
| **Item_ID** | Integer | Unique identifier for each product |
| **Item_Type** | String | Category of product (e.g., Fruits, Snacks, Beverages) |
| **Item_Fat_Content** | String | Fat content level: "Low Fat" or "Regular" |
| **Item_Price** | Decimal | Product price in currency |
| **Item_Weight** | Decimal | Weight of product in units |
| **Item_Visibility** | Decimal | Shelf visibility percentage |
| **Item_MRP** | Decimal | Maximum Retail Price |
| **Outlet_ID** | Integer | Unique identifier for each outlet/store |
| **Outlet_Establishment_Year** | Integer | Year the outlet was established |
| **Outlet_Size** | String | Size category: "Small", "Medium", "High" |
| **Outlet_Location_Type** | String | Location tier: "Tier 1", "Tier 2", "Tier 3" |
| **Outlet_Type** | String | Store format type |
| **Total_Sales** | Decimal | Total sales amount for transaction |
| **Rating** | Decimal | Customer rating (0.0 to 5.0) |

---

## 🔄 Data Cleaning Applied

### 1. Fat Content Standardization
**Issue:** Inconsistent values (LF, low fat, reg, Regular)  
**Solution:** 
```sql
UPDATE blinkit_data 
SET `Item Fat Content` =
CASE 
    WHEN LOWER(`Item Fat Content`) IN ('lf','low fat') THEN 'Low Fat'
    WHEN LOWER(`Item Fat Content`) = 'reg' THEN 'Regular'
    ELSE `Item Fat Content`
END;
```

### 2. Data Validation
- Removed duplicates
- Handled NULL values
- Validated numeric ranges
- Standardized date formats

---

## 📊 Key Analyses

### 1. Sales Performance
- **Total Sales:** Sum of all transactions
- **Average Sales:** Mean transaction value
- **Sales Growth:** Trend analysis by year

### 2. Product Analysis
- **Top Selling Items:** Ranked by revenue
- **Fat Content Impact:** Low Fat vs Regular sales comparison
- **Product Mix:** Distribution across categories

### 3. Outlet Performance
- **Location Analysis:** Tier 1, 2, 3 performance metrics
- **Store Size Impact:** Small, Medium, Large outlet comparison
- **Establishment Year Trend:** Sales growth over outlet age

### 4. Customer Satisfaction
- **Average Rating:** Mean customer satisfaction
- **Rating Distribution:** By outlet and product type
- **Quality Metrics:** Impact on sales

---

## 🔍 SQL Query Categories

### A. Basic Statistics
```sql
-- Total Sales in Millions
SELECT CAST(SUM(`Total Sales`)/1000000 AS DECIMAL(10,2)) AS 'Total_sales_Million'
FROM blinkit_data;
```

### B. Product Analysis
```sql
-- Top 5 Item Types by Sales
SELECT `Item Type`, SUM(`Total Sales`) AS Total_Sales
FROM blinkit_data
GROUP BY `Item Type`
ORDER BY Total_Sales DESC
LIMIT 5;
```

### C. Location Analysis
```sql
-- Sales by Outlet Location Type
SELECT `Outlet Location Type`, 
       SUM(`Total Sales`) AS Total_Sales,
       AVG(`Rating`) AS Avg_Rating
FROM blinkit_data
GROUP BY `Outlet Location Type`
ORDER BY Total_Sales DESC;
```

### D. Comparative Analysis
```sql
-- Fat Content Comparison by Location
SELECT `Outlet Location Type`,
       SUM(CASE WHEN `Item Fat Content` = 'Low Fat' THEN `Total Sales` ELSE 0 END) AS Low_Fat,
       SUM(CASE WHEN `Item Fat Content` = 'Regular' THEN `Total Sales` ELSE 0 END) AS Regular
FROM blinkit_data
GROUP BY `Outlet Location Type`;
```

---

## 📈 Power BI Dashboard Components

### KPI Cards
- **Total Sales:** Headline metric
- **Average Rating:** Customer satisfaction
- **Number of Items:** Inventory count
- **Average Transaction:** Transaction value

### Visualizations
1. **Pie Charts:** Sales distribution by size, fat content
2. **Bar Charts:** Sales by item type, location
3. **Line Charts:** Trend analysis over years
4. **Matrix:** Multi-dimensional analysis

### Filters Applied
- Year establishment
- Location type (Tier 1/2/3)
- Outlet size
- Product category

---

## 🐍 Python Analysis Details

### Libraries Used
```python
import pandas as pd        # Data manipulation
import numpy as np         # Numerical operations
import matplotlib.pyplot   # Basic visualization
import seaborn as sns      # Advanced visualization
```

### Analysis Steps
1. **Data Loading:** Read CSV file
2. **Data Exploration:** Shape, columns, data types
3. **Data Cleaning:** Standardize values
4. **EDA:** Statistical summaries
5. **Visualization:** Charts and graphs
6. **Insights:** Business conclusions

---

## 📌 Important Notes

- All monetary values are in local currency
- Ratings are on a scale of 0 to 5
- Outlet size categories: Small, Medium, High
- Location tiers represent urban hierarchy (Tier 1 = Urban, Tier 3 = Rural)

---

## 🔄 Data Update Frequency
Current analysis is snapshot-based. For real-time updates, connect live data source to Power BI.

---

**Document Version:** 1.0  
**Last Updated:** March 2026  
**Next Review:** As needed for new insights
