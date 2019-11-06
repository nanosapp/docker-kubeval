FROM scratch
COPY ./kubeval /kubeval
ENTRYPOINT /kubeval
