from flask import Blueprint


bp = Blueprint('main', __name__)

from app.main import routes
from app.main.modules import objects_detection
