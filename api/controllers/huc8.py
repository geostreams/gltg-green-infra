from flask import abort, jsonify, make_response
from models.huc8 import HUC8, HUC8Schema


def huc8_get(page=None, limit=None):  # noqa: E501
    """Get all HUC8s

     # noqa: E501

    :param page: The page number
    :type page: int
    :param limit: The number of items per page. If limit is less than 1, then all the items matching the query will be returned.
    :type limit: int

    :rtype: Pagination
    """
    huc8s = HUC8.query.order_by(HUC8.name).all()

    # Serialize the data for the response
    huc8_schema = HUC8Schema(many=True)
    data = huc8_schema.dump(huc8s)
    return jsonify(data)