# -*- coding: utf-8 -*-
class Rubytter
  class Connection
    attr_reader :protocol, :port, :proxy_uri, :enable_ssl

    def initialize(options = {})
      @proxy_host = options[:proxy_host]
      @proxy_port = options[:proxy_port]
      @proxy_user = options[:proxy_user_name]
      @proxy_password = options[:proxy_password]
      @proxy_uri = nil
      @enable_ssl = options[:enable_ssl]
      @port = options[:port]

      if @enable_ssl
        @protocol = "https"
        @port = 443 unless @port
      else
        @protocol = "http"
        @port = 80 unless @port
      end

      if @proxy_host
        @http_class = Net::HTTP::Proxy(@proxy_host, @proxy_port,
                                       @proxy_user, @proxy_password)
        @proxy_uri =  "#{@protocol}://" + @proxy_host + ":" + @proxy_port.to_s + "/"
      else
        @http_class = Net::HTTP
      end
    end

    def start(host, port = nil, &block)
      http = @http_class.new(host, port || @port)
      http.use_ssl = @enable_ssl
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE if http.use_ssl?
      http.start(&block)
    end
  end
end
