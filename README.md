# SQL Data Analysis Portfolio Project
📖  Welcome to the **SQL Data Analysis Portfolio Project** repository!

This repository contains a comprehensive SQL data analysis project that walks through the entire analysis workflow, from initial Exploratory Data Analysis (EDA) to advanced analytics and final report building. The project is designed to showcase practical, real-world SQL skills that are directly applicable to data analyst roles.

---

📬 **Project Overview**
---
This project demonstrates a systematic approach to extracting insights from a relational database. It is broken down into two main phases:

**Exploratory Data Analysis (EDA)**: 
- Understanding the database schema
- Exploring the dimensions and measures within the data
- Performing foundational analysis to uncover initial insights

**Advanced Analytics**: 
- The second phase builds upon the EDA by applying advanced SQL techniques to answer complex business questions
- Analyze trends over time
- Segment data
- Build comprehensive reports for business stakeholders

---

🛠️ **Key Concepts & Techniques**
---

**Foundational Analysis**

- **Database Exploration:** Using **information_schema** to understand table structures, columns, and relationships.
- **Dimension & Measure Exploration:** Identifying unique values in dimensions and performing key aggregations **(SUM, AVG, COUNT)** on measures.
- **Date Exploration:** Analyzing the time span of the data using **MIN**, **MAX**, and **DATEDIFF**.
- **Magnitude & Ranking Analysis:** Using **GROUP BY**, **ORDER BY**, and **TOP** to compare performance across different categories.


**Advanced Analytics**

- **Common Table Expressions (CTEs):** Organizing complex queries and building modular, readable code.
- **Window Functions:**
    * Aggregate: Calculating running totals and moving averages.
    * Value: Comparing performance against previous periods using LAG.
    * Ranking: Using **ROW_NUMBER** for complex ranking scenarios.
- **Change Over Time Analysis:** Tracking trends and seasonality by aggregating data by date parts.
- **Part-to-Whole Analysis:** Calculating the percentage contribution of different segments to the total.
- **Data Segmentation:** Grouping data into meaningful categories (e.g., VIP customers, high-value products) using **CASE WHEN** statements.
---

📈 **Analysis Walkthrough**
---

The project is structured logically through a series of SQL queries that build upon one another.

**Part 1: Exploratory Data Analysis (EDA) Framework**

The EDA follows a six-step framework to thoroughly understand the dataset:
1. **Database Exploration:** What tables, views, and columns exist?
2. **Dimension Exploration:** What are the unique countries, categories, etc.?
3. **Date Exploration:** What is the time period covered by the data?
4. **Measure Exploration:** What are the key business metrics (total sales, total customers)?
5. **Magnitude Analysis:** Who are the most valuable customers? Which countries generate the most revenue?
6. **Ranking Analysis:** What are the top 5 best-selling products?


**Part 2: Building Comprehensive Reports**

Using advanced techniques, we construct two final reports that consolidate key insights for stakeholders:

📊 **Customer Report**
A detailed report that provides a 360-degree view of customers, including:
1. **Segmentation:** VIP, Regular, and New customers.
2. **Demographics:** Age groups.
3. **Aggregations:** Total orders, sales, and quantity.
4. **KPIs:** Recency, Average Order Value (AOV), and Average Monthly Spend.


📦 **Product Report**
An in-depth report that analyzes product performance, including:
1. **Details:** Name, category, and cost.
2. **Segmentation:** High, Medium, and Low revenue products.
3. **Aggregations:** Total revenue and orders.
4. **KPIs:** Recency, Average Revenue per Order, and Average Monthly Revenue.

---

🏗️ **Repository Structure**
---
```
data-analysis-project/
|
├── datasets/             
│   ├── gold.fact_sales
│   ├── gold.dimensions_customers
│   └── gold.dimensions_products
|
├── scripts/                               # SQL scripts for EDA & Advanced Analytics
│   ├── init_database/                     # Scripts for extracting and loading raw data
│   ├── changes_over_time/                 # Analyze trends by month and year
│   ├── cumulative_analysis/               # Compute cumulative metrics over time
│   ├── performance_analysis/              # Evaluate performance across dimensions
│   ├── part_to_whole_analysis/            # Explore part-to-whole relationships
│   ├── data_segmentation/                 # Segment data by cost or customer traits
│   └── report/                            # Build reports and views for customers and products
|
├── README.md             # Project overview and instructions
├── LICENSE               # License information for the repository
├── .gitignore            # Files and directories to be ignored by Git
└── requirements.txt      # Dependencies and requirements for the project
```

---

📜 **License**
---
This project is licensed under the MIT License. You can use, modify, and share this project with proper credit.
 __________________________________

💁🏻‍♀️ **About Me**
---
Hi there! I'm **Syeda Abeer Fatima**, a data enthusiast passionate about turning raw data into meaningful insights. This project gave me the opportunity to sharpen my skills in SQL exploratory data analysis, query optimization, and reporting while simulating real-world analytics workflows.
I enjoy asking the right questions, building structured solutions, and uncovering trends hidden within datasets. Outside of data, I love reading books, learning new things, and simplifying complex challenges into clear answers.

Feel free to connect with me — I’d love to share ideas, exchange feedback, and grow together in the data space!

[Connect with me on LinkedIn](http://www.linkedin.com/in/abeer3003)







