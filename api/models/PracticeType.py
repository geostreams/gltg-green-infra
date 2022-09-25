from sqlalchemy import Column, Float, Text, Integer, String
from geoalchemy2 import Geometry
from marshmallow_sqlalchemy import SQLAlchemySchema, fields
from marshmallow_sqlalchemy.convert import ModelConverter as BaseModelConverter
from config import db, ma


class PracticeType(db.Model):
    __tablename__ = "practice_types"
    practice_type_id = Column(Integer, primary_key=True, index=True)
    practice_category_type_name = Column(String(255))
    practice_category = Column(String(255))
    practice_source = Column(String(255))
    practice_definition = Column(Text)


class PracticeTypeSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = PracticeType
        sqla_session = db.session