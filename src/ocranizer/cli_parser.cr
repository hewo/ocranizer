require "cli"
require "./version"
require "./collection"

module Ocranizer
  class Command < Cli::Supercommand
    class Options
      version
      help
    end

    class Add < Cli::Command
      class Options
        # arg "name"
        bool "--event"
      end

      def run
        puts "add element"
        puts "  type:" + (options.event? ? "event" : "todo")
        puts unparsed_args
        puts nameless_args
      end
    end

    class List < Cli::Command
      def run
        puts "list"
        c = Collection.new
        c.load

        todos = c.todos
        events = c.events
        puts render_array_of_entities(todos + events)
      end

      def render_array_of_entities(array)
        return String.build do |str|
          array.each do |e|
            str << e.to_s_inline
            str << "\n"
          end
        end
      end
    end

    class Show < Cli::Command
    end

    class Change < Cli::Command
    end

    # def run
    #  puts "Command me"
    # end
    def version!
      puts "Version: #{Ocranizer::VERSION}"
      exit
    end
  end
end
