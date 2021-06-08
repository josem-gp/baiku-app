module ApplicationHelper
  def active_class(path)
    if request.path == path
      return 'navbar-active'
    else
      return ''
    end
  end
end

