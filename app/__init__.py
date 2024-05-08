import os

from flask import Flask

from config import Config


def create_app(config_class=Config):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_object(config_class)

    # Initialize Flask extensions here

    # Register blueprints here
    from app.main import bp as main_bp

    app.register_blueprint(main_bp)

    # a simple page that says hello
    @app.get("/ping")
    def ping():
        return "pong"

    return app
