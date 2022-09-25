from models.PracticeType import PracticeType, PracticeTypeSchema
from connexion.lifecycle import ConnexionResponse
from sqlalchemy import exc


def practice_types_get(page=None, limit=None):  # noqa: E501
    """Get all Practice Types

     # noqa: E501

    :param page: The page number
    :type page: int
    :param limit: The number of items per page. If limit is less than 1, then all the items matching the query will be returned.
    :type limit: int

    :rtype: Pagination
    """
    try:
        practice_types = PracticeType.query.order_by(PracticeType.practice_category).all()

        # Serialize the data for the response
        practice_types_schema = PracticeTypeSchema(many=True)

        data = practice_types_schema.dump(practice_types)
        return ConnexionResponse(status_code=200, body=data)
    except exc.SQLAlchemyError:
        return ConnexionResponse(status_code=500, body=[])

