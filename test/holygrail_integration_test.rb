require 'test/test_helper'

class HolyGrailIntegrationTest < ActionController::IntegrationTest
  test "api" do
    assert_nothing_raised { js("1 + 1") }
    assert_nothing_raised { execute_javascript("1 + 1") }
  end

  test "parses simple js" do
    assert_equal 2, js('1+1')
  end

  test "every test is a different context" do
    js("foo = 'bar'")
    assert_equal 'bar', js('foo')
  end
  test "every test is a different context 2" do
    assert_raises(Johnson::Error) { js('foo') }
  end

  test "response context doesn't bleed into next response" do
    get '/foo'
    js("foo = 'bar'")
    assert_equal 'bar', js('foo')

    get '/foo'
    assert_raises(Johnson::Error) { js('foo') }
  end

  test "DOM" do
    get '/foo'
    assert_equal 'Foo', js("document.title")
    assert_equal  2,    js("document.getElementsByTagName('div').length")
  end

  test "resolves <script scr> URIs" do
    get '/bar'
    assert_equal 'grail', js("holy()") #src with double quotes + absolute path
    assert_equal 'foo',   js("foo()")  #src with single quotes + relative path

    # other paths should be left intact
    assert_equal '/javascripts/application.js',
      js("document.getElementsByTagName('a')[0].href")
  end
end

