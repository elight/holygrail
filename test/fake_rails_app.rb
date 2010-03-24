class Rails
  def self.root
    Pathname(__FILE__).dirname.parent.expand_path
  end
end

module ActionController
  module Session
    class CookieStore
      # Just shaddup already and let me test this!
      def ensure_session_key(key); end
      def ensure_secret_secure(key); end
    end
  end
end

ActionController::Routing::Routes.draw do |map|
  map.connect '/foo', :controller => 'holy_grails', :action => 'foo'
  map.connect '/bar', :controller => 'holy_grails', :action => 'bar'
end

class HolyGrailsController < ActionController::Base
  def foo
    render :text => <<-HTML
      <html>
        <head>
          <title>Foo</title>
        </head>
        <body>
          <div></div>
          <div></div>
        </body>
      </html>
    HTML
  end

  def bar
    render :text => <<-HTML
      <html>
        <head>
          <script src="/javascripts/application.js"></script>
          <script src='javascripts/foo.js'></script>
        </head>
        <body>
          <a href="/javascripts/application.js">local uri</a>
        </body>
      </html>
    HTML
  end
end


