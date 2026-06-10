# Student Exam Performance Prediction

An end-to-end machine learning web application that predicts a student's expected math score from demographic, academic, and test-preparation inputs. The project includes data ingestion, preprocessing, model training, saved prediction artifacts, a Flask web interface, and an Azure App Service deployment workflow.

## Project Overview

This project uses a regression model to estimate `math_score` using the following input features:

- Gender
- Race or ethnicity group
- Parental level of education
- Lunch type
- Test preparation course status
- Reading score
- Writing score

The application serves a simple form through Flask. After a user submits the form, the app loads the saved preprocessing pipeline and trained model from the `artifacts/` directory, transforms the input, and returns the predicted math score.

## Live App

Azure App Service URL:

```text
https://parth-student-score-06110006.azurewebsites.net
```

Prediction form:

```text
https://parth-student-score-06110006.azurewebsites.net/predictdata
```

## Tech Stack

- Python
- Flask
- Pandas and NumPy
- Scikit-learn
- CatBoost
- XGBoost
- HTML templates with Jinja
- GitHub Actions
- Azure App Service

## Repository Structure

```text
.
|-- app.py                              # Flask application entrypoint
|-- requirements.txt                    # Python dependencies
|-- setup.py                            # Package setup configuration
|-- artifacts/                          # Saved datasets, model, and preprocessor
|   |-- data.csv
|   |-- train.csv
|   |-- test.csv
|   |-- model.pkl
|   `-- preprocessor.pkl
|-- notebook/                           # EDA and model training notebooks
|   |-- 1 . EDA STUDENT PERFORMANCE .ipynb
|   |-- 2. MODEL TRAINING.ipynb
|   `-- data/stud.csv
|-- src/
|   |-- components/
|   |   |-- data_ingestion.py
|   |   |-- data_transformation.py
|   |   `-- model_trainer.py
|   |-- pipeline/
|   |   |-- predict_pipeline.py
|   |   `-- train_pipeline.py
|   |-- exception.py
|   |-- logger.py
|   `-- utils.py
|-- templates/
|   |-- index.html
|   `-- home.html
`-- .github/workflows/
    `-- azure-app-service.yml
```

## Machine Learning Flow

1. Data is loaded from `notebook/data/stud.csv`.
2. The dataset is split into training and testing sets.
3. Numerical features are imputed and scaled.
4. Categorical features are imputed, one-hot encoded, and scaled.
5. Multiple regression models are trained and compared:
   - Random Forest
   - Decision Tree
   - Gradient Boosting
   - Linear Regression
   - XGBoost Regressor
   - CatBoost Regressor
   - AdaBoost Regressor
6. The best-performing model is saved as `artifacts/model.pkl`.
7. The preprocessing object is saved as `artifacts/preprocessor.pkl`.
8. The Flask app uses these saved artifacts for live predictions.

## Local Setup

Clone the repository:

```bash
git clone https://github.com/perrysolid/End-to-End-MLops-pipeline.git
cd End-to-End-MLops-pipeline
```

Create and activate a virtual environment:

```bash
python3 -m venv venv
source venv/bin/activate
```

For Windows PowerShell:

```powershell
python -m venv venv
venv\Scripts\Activate.ps1
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Run the Flask app:

```bash
python3 app.py
```

Open the app in your browser:

```text
http://127.0.0.1:5000
```

Use the prediction form at:

```text
http://127.0.0.1:5000/predictdata
```

## Prediction Inputs

The web form accepts:

- Gender: `male` or `female`
- Race or ethnicity: `group A`, `group B`, `group C`, `group D`, or `group E`
- Parental education level
- Lunch type: `standard` or `free/reduced`
- Test preparation course: `completed` or `none`
- Reading score from 0 to 100
- Writing score from 0 to 100

The output is the predicted math score.

## Training the Model

The training workflow is implemented across these files:

- `src/components/data_ingestion.py`
- `src/components/data_transformation.py`
- `src/components/model_trainer.py`
- `src/utils.py`

To retrain from the source dataset, run:

```bash
pip install -r requirements-dev.txt
```

```bash
python3 src/components/data_ingestion.py
```

The first command installs training-only libraries such as CatBoost, XGBoost, Matplotlib, and Seaborn. The second command reads the dataset, creates train/test splits, builds the preprocessing object, trains candidate models, selects the best model, and saves the updated artifacts.

## Azure Deployment

The repository includes a GitHub Actions workflow for Azure App Service deployment:

```text
.github/workflows/azure-app-service.yml
```

This project is configured to deploy to:

```text
parth-student-score-06110006
```

The GitHub Actions workflow uses this secret:

```text
AZURE_CREDENTIALS
```

Every push to `main` builds and deploys the Flask app to Azure App Service.

## Important Notes

- The app expects `artifacts/model.pkl` and `artifacts/preprocessor.pkl` to exist before prediction.
- Keep large generated files and local virtual environments out of commits.
- If you retrain the model, commit the updated artifacts only when you intentionally want the deployed app to use the new model.

## Author

Parth Mishra
