# This file could have any name:
# by default it will get included into all views because of the default `require_tree .`
# in `application.js`.

# Using a file with the same name as the controllor
# for Javascript related to that controller is just a convention.

# You need to do extra work for this to be run only on certain controllers / pages,
# e.g. as discussed in: http://stackoverflow.com/questions/6167805/using-rails-3-1-where-do-you-put-your-page-specific-javascript-code

# Each coffescript file is compiled separately and put inside it's own IIFE.
# If you want variables to be visible globally, you must use `self`:

@controller0 = 0

# A sane pattern is to define one class per file, exposing a single global name per file,
# putting all functionality inside the class, and then to export the class globally:

class Controller0
  constructor: ->
    @member = 0

  method: ->
    @member

@Controller0 = Controller0
