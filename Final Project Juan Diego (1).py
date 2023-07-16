#!/usr/bin/env python
# coding: utf-8

# # HR Attrition project - Juan Diego
# 
# This project will explain possible causes of why employees inside a company decide to quit their job.

# In[2]:


import pip
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt


# In[13]:


Hrattr = 'HR attrition.csv'
df = pd.read_csv(Hrattr)
df


# In[112]:


df.shape


# In[158]:


df.columns


# In[114]:


df.dtypes


# In[29]:


df.isnull().sum()


# In[28]:


statistics = df.describe()
print(statistics)


# We can see through the descriptive statistics that there are columns that have unique values and doesnt help that much with the analysis. For example "Employeecount" That has value of 1, or "StandardHours", "DailyRate","HourlyRate  "Over18"

# In[14]:


Dropcolumn ='Over18'
Dropcolumn ='DailyRate'
Dropcolumn ='HourlyRate'
Dropcolumn ='EmployeeCount'
Dropcolumn ='StandardHours'
df = df.drop(Dropcolumn,axis=1)


# In[160]:


df


# In[34]:


df


# # Correlation and possible explanations

# We are going to create a correlation matrix in order to find possible patterns of what is most valuable in the company.

# In[258]:


sns.heatmap(df.corr().round(2))


# Then, we proceed to create another column by categorizing the ages into 3 group ages

# In[52]:


def Age_range(Age):

    if Age >= 18 and Age <= 35:
        return '18 to 35'
    elif Age > 35 and Age <= 50:
        return '35 to 50'
    elif Age > 50:
        return '50 or more'
    else:
        return 'Unknown'
    
dfAttrition['AgeGroup'] = dfAttrition['Age'].apply(Age_range)
dfAttrition


# Histogram showing the attrition by age group

# In[54]:


agehist = sns.FacetGrid(dfAttrition, col='Attrition')
agehist.map(plt.hist, 'AgeGroup', bins=3)


# Histogram showing the attrition by Gender

# In[39]:


sns.countplot(x = "Attrition", data = df)


# In[40]:


(df.groupby('Attrition').Attrition.count() / df['Attrition'].count()) *100


#  We can see that there is an Attrition of **16.12%** among all Employees.

# In[41]:


dfAttrition = df[df["Attrition"] == "Yes"]
dfNoAttrition = df[df["Attrition"] == "No"]
sns.countplot(x = "Gender", data = dfAttrition)


# In[70]:


pd.crosstab([dfAttrition["Department"], dfAttrition["Gender"]], dfAttrition["JobSatisfaction"], 
    margins = True).style.background_gradient(cmap = "summer_r")


# We can clearly see low satisfaction jobs within the categories.  Research and Development department has critical negative ratings and is increasing considerably the attritions metric.  Human resources apparently is doing good and Sales can do better also. From this finding we are going to give a further look to R&D

# In[64]:


pd.crosstab([dfAttrition["Department"], dfAttrition["Gender"]], dfAttrition["OverTime"], 
    margins = True).style.background_gradient(cmap = "summer_r")


# In[18]:


pd.crosstab([dfAttrition["Department"], dfAttrition["Gender"]], dfAttrition["WorkLifeBalance"], 
    margins = True).style.background_gradient(cmap = "summer_r")


# Also, the percentage of employees quiting tend to have worked less than 5 years in the company. This means that most of the attritions that are explained by Junior - Mid Seniors professionals in which their desires are not fulfilled and want to try new experiences

# In[43]:


plt.figure(figsize=(10, 6))
sns.scatterplot(x='YearsAtCompany', y='TotalWorkingYears', data=dfAttrition, hue='Department')
plt.title('YearsatCompany vs TotalWorkingYears')
plt.xlabel('YearsatCompany')
plt.ylabel('TotalWorkingYears')
plt.legend(title='Department')
plt.show()


# # Monthly Income
# We can clearly see that there is a considerable difference is the average monthly income comparing the cluster that quits more the job (18 to35)

# In[72]:


mean_salary = dfAttrition.groupby('AgeGroup')['MonthlyIncome'].mean()
mean_salary


# It can be inferred that in order to retain talent is needed to give rewards, bonuses or even promotions. We proceed to analyze the results with a boxplot to see the distribution of the data. By just looking it we can see a type of skewness in the salary.

# In[82]:


plt.boxplot([dfAttrition[dfAttrition['AgeGroup'] == '18 to 35']['MonthlyIncome'],
             dfAttrition[dfAttrition['AgeGroup'] == '35 to 50']['MonthlyIncome'],
             dfAttrition[dfAttrition['AgeGroup'] == '50 or more']['MonthlyIncome']],
            labels=['18 to 35', '35 to 50', '50 or more'])

# Set labels and title
plt.xlabel('AgeGroup')
plt.ylabel('MonthlyIncome')
plt.title('Salary Distribution by Age Group')

# Display the plot
plt.show()


# In[20]:


dfAttrition.groupby("OverTime").OverTime.count()/ dfAttrition['OverTime'].count() *100


# In[ ]:


Moreover, we can see that the employees that tend to quit their jobs are the ones who don´t have promotions. Is recommended to dig in into this case because probably the sense of reward and gratitud towards the employee is an important factor that the company is leaving behind.


# In[66]:


dfAttrition.groupby('YearsSinceLastPromotion').YearsSinceLastPromotion.count()


# # Recommendations
# 
#  Implement policies such as remote work options, flexible hours, or compressed workweeks to provide employees with more control over their schedules.
#  
#  Monitor employee workloads to ensure they are manageable and realistic. Consider redistributing tasks or hiring additional resources if necessary.
#  
#  Provide a clear career progression plan for researchers, with opportunities for advancement and skill development.
#   Invest in the professional development of researchers by providing opportunities for training, attending conferences, and publishing their work. 
#   
#   Conduct regular surveys or feedback sessions to understand the specific challenges faced by researchers in the department. Actively listen to their concerns and suggestions
#   
#   Offer performance-based bonuses or incentives tied to individual or team research achievements.
#    
#    Create pathways for career advancement within the Research department. This can include opportunities for promotions, access to leadership training programs
#    
#    Implement a recognition program that recognizes researchers' accomplishments and contributions. Celebrate milestones in research, successful projects, and publications. Regular feedback and constructive feedback can boost morale and job satisfaction.
#    
