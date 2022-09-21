from flask import abort, jsonify, make_response
from models.huc8 import HUC8, HUC8Schema
from sqlalchemy import exc


def huc8_get(page=None, limit=None):  # noqa: E501
    """Get all HUC8s

     # noqa: E501

    :param page: The page number
    :type page: int
    :param limit: The number of items per page. If limit is less than 1, then all the items matching the query will be returned.
    :type limit: int

    :rtype: Pagination
    """

    try:
        huc8s = HUC8.query.order_by(HUC8.name).all()

        # Serialize the data for the response
        huc8_schema = HUC8Schema(many=True)

        data = huc8_schema.dump(huc8s)
        return jsonify({"response": 200, "results": data})
    except exc.SQLAlchemyError:
        return jsonify({"response": 500, "results": []})


def huc8_get_id(huc8_id):  # noqa: E501
    """Get a single HUC8 by id

     # noqa: E501

    :param huc8_id: HUC8 number
    :type huc8_id: str

    :rtype: HUC8
    """

    try:
        huc8 = HUC8.query.filter_by(huc8=huc8_id).all()

        # Serialize the data for the response
        huc8_schema = HUC8Schema(many=True)
        data = huc8_schema.dump(huc8)
        if len(data) == 0:
            return jsonify({"response": 400, "results": []})
        else:
            return jsonify({"response": 200, "results": [data]})
    except exc.SQLAlchemyError:
        return jsonify({"response": 500, "results": []})
