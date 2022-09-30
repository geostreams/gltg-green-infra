from sqlalchemy import ForeignKey
from config import db

huc_practice_relations = db.Table('huc_practice_relations',
                                  db.Column('huc8_id', ForeignKey('huc8.huc8')),
                                  db.Column('practice_id', ForeignKey('practice.practice_id'))
                                  )