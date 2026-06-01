---
layout: post
title: Build a Reusable scikit-learn Pipeline
date: 2026-08-17 09:00 +1000
categories: [Python, AI]
tags: [python, machine-learning, regression, scikit-learn]
description: Keep preprocessing and regression together in a scikit-learn Pipeline, evaluate it, and save the fitted model.
---

A scikit-learn `Pipeline` keeps preprocessing and prediction steps together.
That matters during evaluation: each cross-validation fold should fit its
preprocessing steps only on that fold's training rows.

## Create Sample Data

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

## Build the Pipeline

```python
from sklearn.impute import SimpleImputer
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler

pipeline = Pipeline(
    steps=[
        ("imputer", SimpleImputer(strategy="median")),
        ("scaler", StandardScaler()),
        ("regression", LinearRegression()),
    ]
)
```

## Evaluate the Whole Pipeline

```python
from sklearn.model_selection import KFold, cross_validate

cv = KFold(n_splits=5, shuffle=True, random_state=42)
scores = cross_validate(
    pipeline,
    X,
    y,
    cv=cv,
    scoring=("r2", "neg_mean_absolute_error"),
)

print("R2:", scores["test_r2"])
print("MAE:", -scores["test_neg_mean_absolute_error"])
```

Passing the pipeline into `cross_validate` prevents preprocessing leakage
between the training and validation rows.

## Fit and Save the Model

```python
import joblib

pipeline.fit(X, y)
joblib.dump(pipeline, "house-price-pipeline.joblib")
```

Load it later:

```python
import joblib
import pandas as pd

pipeline = joblib.load("house-price-pipeline.joblib")
new_house = pd.DataFrame([{"area": 140, "bedrooms": 3, "age": 7}])
print(pipeline.predict(new_house))
```

Only load serialized model files from a trusted source.

## Next Steps

Review [Diagnose Linear Regression with Cross-Validation and Residuals](/posts/diagnose-linear-regression-cross-validation-residuals/)
for residual inspection and coefficient cautions.

## References

- [Pipeline API](https://scikit-learn.org/stable/modules/generated/sklearn.pipeline.Pipeline.html)
- [Cross-validation](https://scikit-learn.org/stable/modules/cross_validation.html)
- [Model persistence](https://scikit-learn.org/stable/model_persistence.html)
