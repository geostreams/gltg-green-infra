from sqlalchemy import Column, Float, Text, Integer, String
from config import db, ma
from sqlalchemy.orm import relationship

from models.HUCPracticeRelations import huc_practice_relations


class Practice(db.Model):
    __tablename__ = "practices"
    practice_id = Column(Integer, primary_key=True, index=True)
    city = Column(String(50))
    county = Column(String(50))
    installation_date = Column(Integer)
    cost = Column(Float)
    practice_drainage_area = Column(Float)
    type_id = Column(Integer)

    huc8s = relationship("HUC8", secondary=huc_practice_relations, backref="practices")


class PracticeSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Practice
        sqla_session = db.session
