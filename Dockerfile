FROM node
RUN npm install -g hem
RUN npm install express
RUN npm install express-http-proxy
RUN npm install -g spine.app
RUN mkdir /webui
COPY src/ /webui/src/
COPY start.sh /
COPY webui.js /webui/
CMD ./start.sh
EXPOSE 80
