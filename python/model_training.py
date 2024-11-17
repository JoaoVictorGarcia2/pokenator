# backend/model_training.py
import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import joblib

# Carregar dados
data = pd.read_csv('pokemon.csv')

# Selecionar features e alvo
features = data[['Type 1', 'HP', 'Attack', 'Defense', 'Sp. Atk', 'Sp. Def', 'Speed']]
target = data['Name']

# Pré-processar dados
features = pd.get_dummies(features)

# Dividir dados
X_train, X_test, y_train, y_test = train_test_split(features, target, test_size=0.2, random_state=42)

# Treinar o modelo
model = DecisionTreeClassifier()
model.fit(X_train, y_train)

# Avaliar o modelo
predictions = model.predict(X_test)
print(f'Acurácia: {accuracy_score(y_test, predictions)}')

# Salvar o modelo treinado
joblib.dump(model, 'pokemon_model.pkl')
