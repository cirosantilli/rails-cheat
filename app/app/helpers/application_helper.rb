module ApplicationHelper
  def toc
  end

  def h(inner, n=1, id=true, link=true, id_callback=nil)
    link_open = ""
    link_close = ""
    if id_callback == nil
      id_callback = lambda {|inner, n=1| inner.tr('^A-Za-z0-9', '-')}
    end
    if id
      id = id_callback.call(inner, n)
      id_attr = " id=\"#{id}\""
      if link
        link_open = "<a href=\"##{id}\">"
        link_close = "</a>"
      end
    else
      id_attr = ""
    end
    "<h#{n}#{id_attr}>#{link_open}#{inner}#{link_close}</h#{n}>".html_safe
  end
end
