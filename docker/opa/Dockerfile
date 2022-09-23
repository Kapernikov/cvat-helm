FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install git && \
    git clone https://github.com/openvinotoolkit/cvat && cd cvat && \
    git checkout v2.2.0

FROM openpolicyagent/opa:0.34.2-rootless

COPY --from=0 /cvat/cvat/apps/iam/rules /rules

CMD ["run" ,"--server",  "--addr",  ":8181", "--set=decision_logs.console=true", "/rules" ]
