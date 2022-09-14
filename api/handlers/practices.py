from flask import jsonify
from sqlalchemy import JSON, BigInteger, Column, Float, Text, and_, or_
from utils import db, query