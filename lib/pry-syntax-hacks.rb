class Pry
  alias_method :old_retrieve_line, :retrieve_line

  def retrieve_line(eval_string, *args)
    old_retrieve_line(eval_string, *args)
    Pry.hack_line(eval_string)
  end

  def self.hack_line(eval_string)
    eval_string.gsub!(/\.(@[a-z0-9_]+)/, '.instance_variable_get("\1")')
    eval_string.gsub!(/\.:([a-z0-9_]+[?!]?)/, '.method(:\1)')
    eval_string.gsub!(/\.!([a-z0-9_]+[?!]?)([ \(])(?=(.*))/) { ".send#{$2}:#{$1}#{$3 == ""?"":","}" }
    eval_string.gsub!(/(^|[\s\[{>(<=])((\.\.\/)+)([a-z0-9_@]+)/) { "#{$1}_pry_.binding_or_raise(#{-1 - $2.size / 3}).eval('#{$4}')" }
    eval_string
  end

  def binding_or_raise(n)
    binding_stack[n] or raise "no parent binding"
  end

  class Command
    def target
      unless @target.respond_to?(:unhacked_eval)
        class << @target
          alias_method :unhacked_eval, :eval

          def eval(str, *args)
            unhacked_eval(Pry.hack_line(str.dup), *args)
          end
        end
      end
      @target
    end
  end
end
