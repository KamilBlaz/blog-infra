FROM hashicorp/terraform:1.5.1
WORKDIR /code
ENTRYPOINT [""]

RUN apk add --no-cache py3-pip jq curl nano yarn bash vim \
    && pip3 install awscli --no-cache-dir

COPY ./ ./


