from sqlalchemy import create_engine
# from sqlalchemy.engine.base import Engine
from sqlalchemy.orm import scoped_session, sessionmaker


class Database:

    def __init__(self):
        self.engine = create_engine("postgresql://postgres:password@localhost:5432/gltg-gi")
        self.db_session = scoped_session(sessionmaker(bind=self.engine))

    def get_session(self):
        return self.db_session

    def shutdown(self):
        if self.db_session:
            self.db_session.remove()
        if self.engine:
            self.engine.dispose()


db = Database()
