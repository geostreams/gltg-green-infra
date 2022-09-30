from sqlalchemy import Column, Float, Text
from geoalchemy2 import Geometry

from config import db, ma
from sqlalchemy.orm import relationship

from models.HUCPracticeRelations import huc_practice_relations


class HUC8(db.Model):
    __tablename__ = "huc8"
    huc8 = Column(Text, primary_key=True, index=True)
    name = Column(Text)
    area_acres = Column("areaacres", Float(53))
    states = Column(Text)
    geom = Column("geom", Geometry("MULTIPOLYGON", 4326, from_text="ST_GeomFromEWKT", name="geometry"),
                      index=True)

    practices = relationship("Practice", secondary=huc_practice_relations, backref="huc8s")

# class ModelConverter(BaseModelConverter):
#     SQLA_TYPE_MAPPING = {
#         **BaseModelConverter.SQLA_TYPE_MAPPING,
#         **{Geometry: fields.Field()},
#     }


class HUC8Schema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = HUC8
        exclude = ["geom"]
        sqla_session = db.session

