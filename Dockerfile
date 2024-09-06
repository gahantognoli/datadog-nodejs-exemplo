FROM node:18

ARG DD_API_KEY

ENV DD_API_KEY=$DD_API_KEY \
    DD_AGENT_MAJOR_VERSION=7 \
    DD_APM_ENABLED=true \
    DD_HOSTNAME="shark-dd-trace-sh" \
    DD_SITE="us5.datadoghq.com" \
    DD_APM_NON_LOCAL_TRAFFIC=true \
    DD_ENV="staging" \
    DD_VERSION="1.0.0" \
    DD_SERVICE="shark-dd-trace-sh" \
    DD_PROFILING_ENABLED=true \
    DD_LOGS_INJECTION=true \
    DD_APPSEC_ENABLED=true \
    DD_IAST_ENABLED=true \
    DD_APPSEC_SCA_ENABLED=true

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh | bash && \
    mv /etc/datadog-agent/security-agent.yaml.example /etc/datadog-agent/security-agent.yaml

EXPOSE 80

CMD [ "sh", "-c", "service datadog-agent start && node app.js" ]