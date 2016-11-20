require_relative 'bloc_works/version'
require_relative "bloc_works/dependencies"
require_relative 'bloc_works/router'
require_relative "controller"

module BlocWorks
  class Application
    def call(env)
      # if fav_icon(env).nil?
      #   controller_and_action(env)
      # else
      #   fav_icon(env)
      # end
      # controller_and_action(env)

      rack_app = get_rack_app(env)
      #puts "This is the rack_app: #{rack_app}"
      rack_app.call(env)
    end
  end
end
