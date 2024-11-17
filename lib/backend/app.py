from flask import Flask, request, jsonify
from ml_service import get_next_question

app = Flask(__name__)

@app.route('/next_question', methods=['POST'])
def next_question():
    user_answers = request.get_json()
    next_question = get_next_question(user_answers)
    return jsonify(next_question)

if __name__ == '__main__':
    app.run(debug=True)
