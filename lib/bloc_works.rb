require_relative 'bloc_works/version'
require_relative "bloc_works/dependencies"
require_relative 'bloc_works/router'
require_relative "controller"

module BlocWorks
  class Application
    def call(env)
      if fav_icon(env).nil?
        controller_and_action(env)
      else
        fav_icon(env)
      end
      [200, {'Content-Type' => 'text/html'}, ["Hello Blocheads!"]]
    end
  end
end
