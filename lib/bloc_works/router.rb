require_relative '../controller'

module BlocWorks
  class Application
    def controller_and_action(env)
      _, controller, action, _ = env["PATH_INFO"].split("/", 4)
      controller = controller.capitalize
      controller = "#{controller}Controller"
      controller = Object.const_get(controller)
      controller_instance = controller.new(env)

      # rack_app = get_rack_app(env)
      # puts rack_app.class
      # rack_app.call(env)
    end

    def get_rack_app(env)
      if @router.nil?
        raise "No routes defined"
      end

      @router.look_up_url(env["PATH_INFO"])
    end

    def fav_icon(env)
      if env['PATH_INFO'] == '/favicon.ico'
        # sends to empty 404 page for now
        return [404, {'Content-Type' => 'text/html'}, []]
      end
    end

    def route(&block)
      @router ||= Router.new
      @router.instance_eval(&block)
    end
  end

  class Router
    def initialize
      @rules = []
    end

    def map(url, *args)
      options = {}
      options = args.pop if args[-1].is_a?(Hash)
      options[:default] ||= {}

      destination = nil
      destination = args.pop if args.size > 0
      raise "Too many args!" if args.size > 0

      parts = url.split("/")
      parts.reject! { |part| part.empty? }

      vars, regex_parts = [], []

      parts.each do |part|
        case part[0]
        when ":"
          vars << part[1..-1]
          regex_parts << "([a-zA-Z0-9]+)"
        when "*"
          vars << part[1..-1]
          regex_parts << "(.*)"
        else
          regex_parts << part
        end
      end

      regex = regex_parts.join("/")
      @rules.push({ regex: Regexp.new("^/#{regex}$"),
                    vars: vars, destination: destination,
                    options: options })

      # puts "URL is: #{url}"
      # puts "options are: #{options}"
      # puts "destination is: #{destination}"
      # puts "vars are: #{vars}"
      # puts "regex is: #{regex}"

    end

    def look_up_url(url)
      @rules.each do |rule|
        rule_match = rule[:regex].match(url)

        if rule_match
          options = rule[:options]
          params = options[:default].dup

          rule[:vars].each_with_index do |var, index|
            params[var] = rule_match.captures[index]
          end

          if rule[:destination]
            return get_destination(rule[:destination], params)
          else
            controller = params["controller"]
            action = params["action"]
            return get_destination("#{controller}##{action}", params)
          end
        end
      end
    end

    def get_destination(destination, routing_params = {})
      if destination.respond_to?(:call)
        return destination
      end

      if destination =~ /^([^#]+)#([^#]+)$/
        name = $1.capitalize
        controller = Object.const_get("#{name}Controller")
        return controller.action($2, routing_params)
      end

      raise "Destination not found: #{destination}"
    end

    private
    # # def set_options(*args)
    # #   options = {}
    # #   options = args.pop if args[-1].is_a?(Hash)
    # #   options[:default] ||= {}
    # #   options
    # # end
    # #
    # # def set_destination(*args)
    # #   destination = nil
    # #   destination = args.pop if args.size > 0
    # #   raise "Too many args!" if args.size > 0
    # #   destination
    # # end
    #
    # def split_url_parts(url)
    #   parts = url.split("/")
    #   parts.reject! { |part| part.empty? }
    #   parts
    # end
  end
end
