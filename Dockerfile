FROM python:3.9-slim
ADD api /api
WORKDIR /api
RUN pip install -r requirements.txt
EXPOSE 5000
CMD python app.py