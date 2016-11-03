module BlocWorks
  class Application
    def controller_and_action(env)
      _, controller, action, _ = env["PATH_INFO"].split("/", 4)
      controller = controller.capitalize
      controller = "#{controller}Controller"
      controller = Object.const_get(controller)
      controller_instance = controller.new(env)
      [200, {'Content-Type' => "#{controller}"}, [controller_instance.send(action.to_sym)]]
    end

    def fav_icon(env)
      if env['PATH_INFO'] == '/favicon.ico'
        # sends to empty 404 page for now
        return [404, {'Content-Type' => 'text/html'}, []]
      end
    end
  end
end
