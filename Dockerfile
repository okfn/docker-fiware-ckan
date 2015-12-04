FROM quay.io/okfn/python2:1.0.0

MAINTAINER Open Knowledge <info@okfn.org>

ENV APP_WSGI=ckan.wsgi

ENV GIT_BRANCH=release-v2.4-latest
ENV GIT_URL=https://github.com/ckan/ckan.git

ENV CKAN_INI=production.ini
ENV SRC_DIR=${APP_DIR}/src

RUN mkdir ${WORKSPACE} ${SRC_DIR} && cd ${SRC_DIR} && \
    git clone -b ${GIT_BRANCH} --depth=1 --single-branch \
    ${GIT_URL}  ckan && \
    cd ckan && \
    cp who.ini ${APP_DIR} && \
    python setup.py install && \
    pip install --upgrade -r requirements.txt

COPY ${SETUP}/${APP_CONF} ${SUPERVISOR_DIR}/${APP_CONF}
COPY ${SETUP} ${APP_DIR}
ENV APP_WSGI ckan.wsgi

COPY ${SETUP}/dump_env.conf ${SUPERVISOR_DIR}/dump_env.conf
COPY ${SETUP}/dump_env.py ${APP_DIR}/dump_env.py

WORKDIR ${APP_DIR}

# Add ckan command
RUN ln -s ${APP_DIR}/ckan /usr/bin/ckan
