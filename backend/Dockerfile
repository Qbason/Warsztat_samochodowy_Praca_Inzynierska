FROM python:3.10.6
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
#disable input during install packages
ARG DEBIAN_FRONTEND=noninteractive
#make sure, that output goes to terminal!
ENV PYTHONUNBUFFERED 1
# make our dir default for commands like RUN, CMD etc.
WORKDIR /app
#install packages in venv python based on requirements.txt
COPY requirements.txt /app/requirements.txt
RUN pip3 install -r requirements.txt
#copy code and configuration
COPY ./mechanik /app/
#RUN
CMD ["python3","/app/manage.py","runserver","0.0.0.0:8000"]