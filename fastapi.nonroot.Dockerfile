FROM python:3.9.10-alpine3.15

WORKDIR /usr/data

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN addgroup -S appuser && adduser -S appuser -G appuser  --home /usr/data

ENV PATH=$PATH:/usr/data/.local/bin

COPY ./requirements.txt .

COPY ./app app
RUN pip install -r requirements.txt

RUN chown -R appuser:appuser /usr/data

USER appuser:appuser

EXPOSE 8000/tcp
CMD ["uvicorn","app.main:app","--host", "0.0.0.0", "--port", "8000"]