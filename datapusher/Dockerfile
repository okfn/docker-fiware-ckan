FROM quay.io/okfn/python2:1.0.0

MAINTAINER Open Knowledge <info@okfn.org>

ENV GIT_BRANCH master
ENV GIT_URL https://github.com/ckan/datapusher.git

ENV JOB_CONFIG ${APP_DIR}/datapusher_settings.py

ENV SRC_DIR ${APP_DIR}/src

RUN mkdir ${WORKSPACE} ${SRC_DIR} && cd ${SRC_DIR} && \
    git clone -b ${GIT_BRANCH} --depth=1 --single-branch \
    ${GIT_URL} && \
    cd datapusher && \
    python setup.py install && \
    pip install --no-cache-dir -r requirements.txt

RUN mkdir ${WORKSPACE}/apache_logs && \
    chown -R www-data.www-data ${WORKSPACE}/apache_logs

COPY ${SETUP} ${APP_DIR}
COPY ${SETUP}/${APP_CONF} ${SUPERVISOR_DIR}/${APP_CONF}

EXPOSE 8800

WORKDIR ${APP_DIR}
