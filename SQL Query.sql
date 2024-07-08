with recency as ( -- tính recency dựa vào chỉ số Exited và IsActiveMeber kết hợp lại
    select CustomerID, Tenure as [Years as Client], Exited, [IsActiveMember] ,
        CASE 
    when [IsActiveMember] = 0 and Exited = 1 then 1
    when [IsActiveMember] = 0 and Exited = 0 then 2
    when [IsActiveMember] = 1 and Exited = 1 then 2
    else 4
    end as rfm_recency
    FROM bank_churn

),
frequency as ( --tính frequency
   
    select CustomerID, sum(NumOfProducts)  "Total Products Purchased via the Bank",Tenure -- các yếu tố liên quan đến frequency
    from bank_churn
    group by CustomerID,Tenure
),
monetary as ( -- tính monetary
  
    select CustomerID, EstimatedSalary "Client Salary", Balance, HasCrCard, Point_Earned -- các yếu tố liên quan đến monetary
    from bank_churn
),
rfm as (
SELECT recency.CustomerID, [Years as Client],  "Total Products Purchased via the Bank", "Client Salary", HasCrCard, Exited, IsActiveMember, rfm_recency, Balance,
    ntile(4) over (order by Tenure) as rfm_frequency, -- phân loại frequency theo 4 phần từ thấp đến cao tương ứng từ 1->4 điểm
    ntile(4) over (order by  Point_Earned ) as rfm_monetary  -- phân loại monetary theo 4 phần từ thấp đến cao tương ứng từ 1->4 điểm
from recency, frequency, monetary
where recency.CustomerID = frequency.CustomerID and recency.CustomerID = monetary.CustomerID
),
cte as  -- Bảng Tổng hợp phân loại và dữ liệu
(SELECT rfm.CustomerID, [Years as Client],  "Total Products Purchased via the Bank", cast("Client Salary" as float) "Client Salary" ,
rfm_recency+rfm_frequency+rfm_monetary as rfm_score, rfm_recency,
    CASE  -- Mapping Revenue Ranking để group nhóm
    when rfm_monetary > 2 and HasCrCard = 1 then 'High Spending with Credit Card'
    When rfm_monetary > 2 and HasCrCard = 0 then 'High Spending with no Credit Card'
    When rfm_monetary = 1 and HasCrCard = 0 then 'Low Spending and no Credit Card'
    else 'Normal'
    end as "Revenue Ranking",
    CASE -- Mapping Salay Ranking để group nhóm phân tích đặc điểm
    when "Client Salary" <= 30000 then 'Low Income'
    when "Client Salary" <= 80000  then 'Middle Income'
    when "Client Salary" <= 150000  then 'High Income'
    else 'Very High Income'
    end as "Salary Ranking",
    CASE  -- Mapping Balance Ranking để group nhóm phân loại đặc điểm
    when Balance <= 20000  then 'Minimal Balance'
    when Balance <= 100000 then 'Standard Balance'
    when Balance <= 200000 then 'High Saving Balance'
    else 'High Networth and Substantial Savings Balance'
    end as "Balance Ranking",
    CASE -- Mapping RFM score và Ranking để thống nhất các ranking và phân loại khách hàng theo segment tổng quan nhất
    when rfm_recency+rfm_frequency+rfm_monetary >= 10 and rfm_recency+rfm_frequency+rfm_monetary <=12 then 'Loyal Customer'
    when rfm_recency+rfm_frequency+rfm_monetary >= 7 and rfm_recency+rfm_frequency+rfm_monetary <=9 then 'Potential Customer'
    when rfm_recency+rfm_frequency+rfm_monetary >= 4 and rfm_recency+rfm_frequency+rfm_monetary <=6 then 'Normal Customer' 
    else 'Very Low-value and Inactive'
    end as Overall_ranking
from rfm 
)
Select cte.*, CreditScore, Geography, Gender, Age, cast(Balance as float) Balance, Satisfaction_Score, Card_Type, Point_Earned,
Case  HasCrCard -- Transform định dạng Boolean để dữ liệu thân thiện hơn với người dùng
when   1 then 'Yes'
Else 'No'
end as HasCrCard  ,
Case IsActiveMember
when  1 then 'Yes'
Else 'No'
end as IsActiveMember,
Case Exited
when  1 then 'Yes'
Else 'No'
end as Exited,
Case  Complain
when 1 then 'Yes'
Else 'No'
end as Complain
from cte 
inner join bank_churn on cte.CustomerID = bank_churn.CustomerID -- Join lại với bảng gốc để lấy thêm thông tin liên quan cho mỗi người dùng