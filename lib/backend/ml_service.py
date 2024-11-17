import pandas as pd
import random

# Carrega os dados dos Pokémon
pokemon_data = pd.read_csv('pokemon.csv')

# Lista de perguntas disponíveis para o questionário
questions_pool = [
    {"column": "Legendary", "question": "O Pokémon é lendário?", "options": ["Sim", "Não", "Não Sei"]},
    {"column": "Type 1", "question": "O Pokémon é do tipo Fogo?", "options": ["Sim", "Não", "Não Sei"]},
    {"column": "Type 1", "question": "O Pokémon é do tipo Água?", "options": ["Sim", "Não", "Não Sei"]},
    {"column": "Type 1", "question": "O Pokémon é do tipo Planta?", "options": ["Sim", "Não", "Não Sei"]},
    # Adicione mais perguntas e tipos, se necessário.
]

def get_next_question(answers):
    filtered_data = pokemon_data.copy()

    # Aplica os filtros das respostas
    for answer in answers:
        question_column = answer['column']
        response = answer['response']
        
        if question_column in filtered_data.columns:
            if response == "Sim":
                filtered_data = filtered_data[filtered_data[question_column] == True]
            elif response == "Não":
                filtered_data = filtered_data[filtered_data[question_column] == False]

    # Checa se há apenas um Pokémon restante no filtro
    if len(filtered_data) == 1:
        return {"result": filtered_data.iloc[0].to_dict()}

    elif len(filtered_data) == 0:
        return {"result": "Nenhum Pokémon encontrado com essas características."}

    # Seleciona uma nova pergunta que ainda não foi respondida
    unanswered_questions = [q for q in questions_pool if q["column"] not in [a["column"] for a in answers]]
    
    if unanswered_questions:
        next_question = random.choice(unanswered_questions)
        return {"question": next_question["question"], "options": next_question["options"], "column": next_question["column"]}
    
    return {"result": "Não há mais perguntas para responder."}
