FROM nginx:alpine

# OpenShift runs containers as a random non-root UID, fix permissions
RUN chmod -R 777 /var/cache/nginx /var/run /var/log/nginx && \
    chown -R nginx:0 /usr/share/nginx/html && \
    chmod -R g+rwX /usr/share/nginx/html

COPY index.html style.css /usr/share/nginx/html/

EXPOSE 8080

# Override default nginx port to 8080 (non-root required by OpenShift)
RUN sed -i 's/listen\s*80;/listen 8080;/g' /etc/nginx/conf.d/default.conf

USER nginx
