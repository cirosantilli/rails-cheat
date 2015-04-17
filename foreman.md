# Foreman

TODO split from Rails. Likely everything?

Tool that starts many processes at once, for example one main web process + many works.

Advantages over a plain script:

- one C-C and SIGTERM is sent to all the processes invoked

Files:

-   `Procfile`: main configuration file.

    Bash variable notation like `$PORT` does not imply that the value will be taken from 

-   `.env` and `.procfile`: from those files it is possible to set the bash-like variables of `Procfile`.

    TODO what is the difference between them?

    `.procfile` is YAML:

        port: 3001

    `.env` is yet another magic format:

        PORT=3001

A `foreman stop` command is WONTFIX: <http://stackoverflow.com/questions/18925483/how-to-simply-stop-or-restart-foreman-processes>
