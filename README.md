## Project Overview
This project aims to analyze the customer churn rate at a bank with branches in Germany, France, and Spain. After 10 years of operation, the bank noticed a decline in revenue and a decrease in customer usage of its services. The goal is to identify the reasons behind customer churn and propose solutions to improve customer retention.

## Objectives
1. Analyze the characteristics and reasons behind customer churn.
2. Provide recommendations to improve customer retention.
3. Develop models to predict customer churn.

## Context
The dataset includes information on 10,000 customers with 18 columns representing various attributes such as age, geography, gender, credit score, tenure, balance, number of products, and more.

### Key Columns
- **CustomerId**: Unique identifier for each customer.
- **CreditScore**: Credit score of the customer.
- **Geography**: Branch location of the customer.
- **Gender**: Gender of the customer.
- **Age**: Age of the customer.
- **Tenure**: Number of years the customer has been with the bank.
- **Balance**: Account balance of the customer.
- **NumOfProducts**: Number of products/services used by the customer.
- **HasCrCard**: Whether the customer has a credit card.
- **IsActiveMember**: Whether the customer is an active member.
- **EstimatedSalary**: Estimated annual salary of the customer.
- **Exited**: Whether the customer has left the bank.
- **Complain**: Whether the customer has filed complaints.
- **Satisfaction Score**: Customer's satisfaction score.
- **Card Type**: Type of card held by the customer.
- **Points Earned**: Points earned by the customer.

## Methodology
1. **Data Preprocessing and Transformation:**
   - Check and format the dataset.
   - Convert boolean and categorical variables into user-friendly formats.

2. **Exploratory Data Analysis (EDA):**
   - Analyze the overall business and customer churn situation.
   - Identify high-value and high-potential customers.
   - Understand demographic characteristics and customer activities.

3. **Customer Segmentation:**
   - Use RFM (Recency, Frequency, Monetary) score for customer segmentation.
   - Classify customers into different groups based on their RFM scores.

4. **Model Building and Evaluation:**
   - Develop models to predict customer churn using various algorithms.
   - Evaluate the models based on their performance metrics.

## Key Findings
1. **Churn Rate:**
   - The overall churn rate is 20.38%, which is higher than the industry average of 10-15%.

2. **High-Risk Factors:**
   - Customers with high income and high balance are more likely to churn.
   - High spending with credit cards and accumulated points are indicators of potential churn.

3. **Demographic Insights:**
   - Older customers (especially those aged 35-55) have a higher churn rate.
   - Female customers have a higher churn rate compared to male customers.
   - The German branch has the highest churn rate among the branches.

4. **Activity Insights:**
   - Customers who have filed complaints are more likely to churn.
   - Customers with lower satisfaction scores are more likely to churn.
   - Customers tend to churn after 0-2 years or 8-10 years of service.

## Recommendations
1. **For Potential Customers:**
   - Design reward programs tailored for female customers aged 44, focusing on fashion, health, and travel.
   - Offer significant rewards for long-term customers at 5, 7, and 10-year milestones.
   - Enhance travel benefits like airport lounge access and hotel discounts.
   - Provide personalized financial services focusing on asset accumulation and investment.

2. **For Normal Customers:**
   - Offer competitive interest rates for short-term savings with increasing benefits over time.
   - Implement special benefits for new customers and customized rewards after the initial experience.
   - Launch a referral and loyalty program with exclusive benefits for 3-5 year tenures.
   - Introduce flexible banking products with varying risk levels and terms.

## Prerequisites
- Python 3.x
- Libraries: pandas, numpy, scikit-learn, matplotlib, seaborn
