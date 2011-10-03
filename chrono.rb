# encoding: utf-8

class Chrono
    require 'Time'
    def initialize
        @dictionary = {
            :second => 1,
            :minute => 60,
            :hour => 60**2,
            :day => 60**2 * 24,
            :tomorrow => 60**2 * 24,
            :yesterday => - (60**2 * 24), 
            :week => 60**2 * 24 * 7
        }
    end

    def debug?
        false
    end

    def parse(string, time=Time.now)
        string.scan(/([+\-])?(\d){0,2}\s?(day|week|hour|minute|second|tomorrow|yesterday)s?/) do |match|
            p match if self.debug?
            sign, quantity, type = match
            case sign
                when "+" then time += quantity.to_i * @dictionary[type.to_sym]
                when "-" then time -= quantity.to_i * @dictionary[type.to_sym]
                when nil then time += @dictionary[type.to_sym]
            end
        end
        # Returning the computed time
        "#{string} => #{time}"
    end
end

c = Chrono.new
puts c.parse "-2 days +1 hour +1 minute"
puts c.parse "-3 weeks"
puts c.parse "tomorrow"
puts c.parse "yesterday"
puts c.parse "tomorrow +3 hours"
