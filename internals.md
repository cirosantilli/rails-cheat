# Internals

As with any system, understanding internals helps you understand the API.

In come cases, documentation fails, and opening up the method is the only way to understand anything.

Source code: <https://github.com/rails/rails>

## tmp

-   `pids/server.pid`: PID of the server. File only exists while server is running.

    Specially useful when running Rails daemonized with `rails s -d`.

## Rack

Rails implements a Rack application: the main class `App::Appname` is the rack app.

Rails requires the rack. The default handler for development is WEBrick.

## Source tree

Rails is made of directories which implement independent sections of it.

The major sections are prefixed with `action`, meaningless choice IMHO, but so be it.

Each section has a README which explains what it is about.

- `actionpack`: model and View layers.
- `activesupport`: utility classes.
