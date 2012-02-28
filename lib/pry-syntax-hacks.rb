class Pry
  alias_method :old_retrieve_line, :retrieve_line

  def retrieve_line(eval_string, *args)
    old_retrieve_line(eval_string, *args)

    eval_string.gsub!(/\.(@[a-z0-9_]+)/, '.instance_variable_get("\1")')
    eval_string.gsub!(/\.:([a-z0-9_]+[?!]?)/, '.method(:\1)')
    eval_string.gsub!(/\.!([a-z0-9_]+[?!]?)([ \(])(?=(.*))/) { ".send#{$2}:#{$1}#{$3 == ""?"":","}" }
  end
end
