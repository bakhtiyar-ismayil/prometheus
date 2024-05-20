from prometheus_client
from flask import Flask

"""
Question 3: PLACEHOLDER
"""

"""
Question 10: PLACEHOLDER-1
"""

"""
Question 13: PLACEHOLDER-1
"""

def before_request():
    """
    Question 13: PLACEHOLDER-2
    """

def after_request(response):
    """
    Question 13: PLACEHOLDER-3
    """
    return response

app = Flask(__name__)


@app.get("/products")
def get_products():
    """
    Question 4: PLACEHOLDER-1
    """
    return "product"


@app.post("/products")
def create_product():
    """
    Question 4: PLACEHOLDER-2
    """
    return "created product", 201


@app.get("/cart")
def get_cart():
    """
    Question 4: PLACEHOLDER-3
    """
    return "cart"


@app.post("/cart")
def create_cart():
    """
    Question 4: PLACEHOLDER-4
    """
    return "created cart", 201


@app.errorhandler(404)
def page_not_found(e):
    """
    Question 10: PLACEHOLDER-2
    """
    return "page not found", 404


if __name__ == '__main__':
    """
    Question 5: PLACEHOLDER
    """
    app.run(debug=False, host="0.0.0.0", port='6000')
