FROM bitnami/postgresql:16.4.0-debian-12-r16
LABEL org.opencontainers.image.source=https://github.com/rbaghbanli/bitnami-postgresql-16-cron
LABEL org.opencontainers.image.description="Container for Bitnami PostgreSQL v16 with pg_cron"
LABEL org.opencontainers.image.licenses=MIT
USER root
RUN install_packages curl ca-certificates postgresql-common
RUN curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc \
    --fail \
    https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN install -d /usr/share/postgresql-common/pgdg
RUN echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" \
    > /etc/apt/sources.list.d/pgdg.list
RUN install_packages postgresql-16-cron
RUN mkdir /opt/bitnami/postgresql/lib/bitcode && \
    cp /usr/share/postgresql/16/extension/pg_cron* /opt/bitnami/postgresql/share/extension/ && \
    cp /usr/lib/postgresql/16/lib/bitcode/pg_cron.index.bc /opt/bitnami/postgresql/lib/bitcode/ && \
    cp -r /usr/lib/postgresql/16/lib/bitcode/pg_cron/* /opt/bitnami/postgresql/lib/bitcode/pg_cron/ && \
    cp /usr/lib/postgresql/16/lib/pg_cron.so /opt/bitnami/postgresql/lib/ && \
    chmod 755 /opt/bitnami/postgresql/lib/pg_cron.so
USER 1001
