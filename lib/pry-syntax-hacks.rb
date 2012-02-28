class Pry
  alias_method :old_retrieve_line, :retrieve_line

  def retrieve_line(eval_string, *args)
    old_retrieve_line(eval_string, *args)

    eval_string.gsub!(/\.(@[a-z0-9_]+)/, '.instance_variable_get("\1")')
    eval_string.gsub!(/\.:([a-z0-9_]+[?!]?)/, '.method(:\1)')
    eval_string.gsub!(/\.!([a-z0-9_]+[?!]?)([ \(])(?=(.*))/) { ".send#{$2}:#{$1}#{$3 == ""?"":","}" }
    eval_string.gsub!(/([\s\[{>(<=])((\.\.\/)+)([a-z0-9_@]+)/) { "#{$1}_pry_.binding_or_raise(#{-1 - $2.size / 3}).eval('#{$4}')" }
  end

  def binding_or_raise(n)
    binding_stack[n] or raise "no parent binding"
  end
end
