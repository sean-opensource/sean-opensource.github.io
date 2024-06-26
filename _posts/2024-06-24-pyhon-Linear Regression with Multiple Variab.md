---
layout: post
title: Linear Regression with Multiple Variables in Python
date: 2024-06-25 00:00 +1000
categories: [Python, AI]
tags: [post]
---


# Linear Regression with Multiple Variables in Python: A Detailed Guide

Linear regression is a fundamental technique in machine learning and statistics. It is used to predict a continuous target variable based on one or more input features. When multiple variables (features) are involved, it's called multiple linear regression. In this blog post, we will go through the steps to implement multiple linear regression in Python, using the popular `scikit-learn` library.

## Table of Contents
1. Introduction
2. Prerequisites
3. Step-by-Step Guide
    1. Data Preparation
    2. Data Visualization
    3. Feature Selection
    4. Splitting Data
    5. Training the Model
    6. Making Predictions
    7. Model Evaluation
4. Conclusion

## Introduction
Multiple linear regression aims to model the relationship between two or more explanatory variables and a response variable by fitting a linear equation to observed data. The equation for multiple linear regression looks like this:

\[ y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \cdots + \beta_n x_n + \epsilon \]

Where:
- \( y \) is the dependent variable (target).
- \( x_1, x_2, \ldots, x_n \) are the independent variables (features).
- \( \beta_0 \) is the intercept.
- \( \beta_1, \beta_2, \ldots, \beta_n \) are the coefficients.
- \( \epsilon \) is the error term.

## Prerequisites
Before we start, make sure you have the following packages installed:
- `pandas`
- `numpy`
- `matplotlib`
- `scikit-learn`

You can install these packages using pip:

```bash
pip install pandas numpy matplotlib scikit-learn
```

## Step-by-Step Guide

### 1. Data Preparation
First, we need to load and prepare our dataset. For this example, we'll use a dataset with house prices which includes features like square footage, number of bedrooms, and age of the house.

```python
import pandas as pd

# Load the dataset
data = pd.read_csv('house_prices.csv')

# Display the first few rows of the dataset
print(data.head())
```

### 2. Data Visualization
Visualizing the data helps in understanding the relationships between variables.

```python
import matplotlib.pyplot as plt

# Scatter plot for each feature against the target variable
plt.figure(figsize=(10, 8))
plt.subplot(2, 2, 1)
plt.scatter(data['square_footage'], data['price'])
plt.title('Price vs Square Footage')
plt.xlabel('Square Footage')
plt.ylabel('Price')

plt.subplot(2, 2, 2)
plt.scatter(data['bedrooms'], data['price'])
plt.title('Price vs Bedrooms')
plt.xlabel('Bedrooms')
plt.ylabel('Price')

plt.subplot(2, 2, 3)
plt.scatter(data['age'], data['price'])
plt.title('Price vs Age')
plt.xlabel('Age')
plt.ylabel('Price')

plt.tight_layout()
plt.show()
```

### 3. Feature Selection
Selecting relevant features is crucial for building a good model. For this example, we'll use all available features.

### 4. Splitting Data
Split the data into training and testing sets.

```python
from sklearn.model_selection import train_test_split

# Features and target variable
X = data[['square_footage', 'bedrooms', 'age']]
y = data['price']

# Split the dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
```

### 5. Training the Model
Train the linear regression model using the training data.

```python
from sklearn.linear_model import LinearRegression

# Create the model
model = LinearRegression()

# Train the model
model.fit(X_train, y_train)
```

### 6. Making Predictions
Use the trained model to make predictions on the test set.

```python
# Make predictions on the test set
y_pred = model.predict(X_test)
```

### 7. Model Evaluation
Evaluate the model's performance using metrics such as Mean Absolute Error (MAE), Mean Squared Error (MSE), and R-squared.

```python
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score

# Calculate evaluation metrics
mae = mean_absolute_error(y_test, y_pred)
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

# Print the evaluation metrics
print(f'Mean Absolute Error: {mae}')
print(f'Mean Squared Error: {mse}')
print(f'R-squared: {r2}')
```

## Conclusion
Multiple linear regression is a powerful tool for predicting outcomes based on multiple features. By following the steps outlined in this guide, you can build and evaluate a multiple linear regression model using Python. The `scikit-learn` library makes it straightforward to implement and assess machine learning models.

Remember, the key to a good model is not just in the algorithm itself but also in the quality and preparation of the data. Happy coding!

+++
