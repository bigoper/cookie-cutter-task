#!/bin/bash -e

# Container entrypoint to simplify running the production and dev servers.

# Entrypoint conventions are as follows:
#
#  -  If the container is run without a custom CMD, the service should run as it would in production.
#
#  -  If the container is run with the "dev" CMD, the service should run in development mode.
#
#     Normally, this means that if the user's source has been mounted as a volume, the server will
#     restart on code changes and will inject extra debugging/diagnostics.
#
#  -  If the CMD is "test" or "lint", the service should run its unit tests or linting.
#
#     There is no requirement that unit tests work unless user source has been mounted as a volume;
#     test code should not normally be shipped with production images.
#
#  -  Otherwise, the CMD should be run verbatim.


if [ "$1" = "uwsgi" ]; then
    exec uwsgi --http-socket 0.0.0.0:80 --drop-after-init \
               --uid nobody --gid nogroup \
               --processes ${UWSGI_NUM_PROCESSES:-4} \
               --need-app --module ${NAME}.wsgi:app
elif [ "$1" = "dev" ]; then
    exec runserver --host 0.0.0.0 --port 80
elif [ "$1" = "test" ]; then
    # Install standard test dependencies; YMMV
    pip --quiet install nose mock PyHamcrest coverage
    exec nosetests
elif [ "$1" = "lint" ]; then
    # Install standard linting dependencies; YMMV
    pip --quiet install flake8 flake8-print
    exec flake8 ${NAME}
else
    exec $@
fi
