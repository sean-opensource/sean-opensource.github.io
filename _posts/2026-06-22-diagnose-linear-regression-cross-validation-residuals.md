---
layout: post
title: Diagnose Linear Regression with Cross-Validation and Residuals
date: 2026-06-22 09:00 +1000
categories: [Python, AI]
tags: [python, machine-learning, regression, scikit-learn]
description: Evaluate a linear regression model with a holdout set, cross-validation, and residual inspection.
---

A fitted regression model is only the beginning. Evaluate it on unseen data,
compare cross-validation folds, and inspect residuals before trusting its
predictions.

## Build a Reproducible Example

```python
import pandas as pd

data = pd.DataFrame(
    {
        "area": [60, 75, 90, 105, 120, 135, 150, 165, 180, 195],
        "bedrooms": [1, 2, 2, 3, 3, 3, 4, 4, 4, 5],
        "age": [35, 20, 18, 12, 10, 8, 6, 5, 4, 2],
        "price": [310, 365, 420, 505, 560, 615, 690, 735, 790, 875],
    }
)

X = data[["area", "bedrooms", "age"]]
y = data["price"]
```

## Hold Out Test Data

```python
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error, r2_score
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.3, random_state=42
)

model = LinearRegression()
model.fit(X_train, y_train)
predictions = model.predict(X_test)

print("MAE:", mean_absolute_error(y_test, predictions))
print("R2:", r2_score(y_test, predictions))
```

## Add Cross-Validation

```python
from sklearn.model_selection import KFold, cross_validate

cv = KFold(n_splits=5, shuffle=True, random_state=42)
scores = cross_validate(
    LinearRegression(),
    X,
    y,
    cv=cv,
    scoring=("r2", "neg_mean_absolute_error"),
    return_train_score=True,
)

print("Test R2:", scores["test_r2"])
print("Test MAE:", -scores["test_neg_mean_absolute_error"])
```

Look at the spread between folds. A single good split can hide an unstable
model.

## Inspect Residuals

```python
import matplotlib.pyplot as plt

residuals = y_test - predictions

plt.scatter(predictions, residuals)
plt.axhline(0, color="black", linestyle="--")
plt.xlabel("Predicted price")
plt.ylabel("Residual")
plt.show()
```

A useful first residual plot should look roughly scattered around zero. A
curve, widening spread, or obvious groups suggests that the model is missing a
pattern.

Correlated features can also make coefficients unstable. Cross-validation
helps reveal whether results change substantially with the training rows.

## Next Steps

A later article will cover building a reusable scikit-learn pipeline to keep
preprocessing and evaluation together.

## References

- [Cross-validation](https://scikit-learn.org/stable/modules/cross_validation.html)
- [Inspection](https://scikit-learn.org/stable/inspection.html)
- [Linear-model coefficient pitfalls](https://scikit-learn.org/stable/auto_examples/inspection/plot_linear_model_coefficient_interpretation.html)
