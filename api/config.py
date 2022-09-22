import os
# from dotenv import load_dotenv
import connexion
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow

# Import environment variables
# load_dotenv()

# Create the connexion application instance
connexion_app = connexion.FlaskApp(__name__, specification_dir='swagger/')

# Get the underlying Flask app instance
app = connexion_app.app

# Build the Postgres URL for SqlAlchemy
username = os.environ.get('DB_USER')
password = os.environ.get('DB_PASSWORD')
host = os.environ.get('HOST')
pg_url = "postgresql://" + username + ":" + password + "@" + host + ":5432/gltg-gi"


# Configure the SqlAlchemy part of the app instance
app.config["SQLALCHEMY_ECHO"] = True
app.config["SQLALCHEMY_DATABASE_URI"] = pg_url
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

# Create the SqlAlchemy db instance
db = SQLAlchemy(app)

# Initialize Marshmallow
ma = Marshmallow(app)