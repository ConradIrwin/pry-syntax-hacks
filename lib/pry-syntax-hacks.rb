class Pry
  alias_method :old_retrieve_line, :retrieve_line

  def retrieve_line(*args)
    val = old_retrieve_line(*args)

    val.gsub(/\.(@[a-z0-9_]+)/, '.instance_variable_get("\1")').
        gsub(/\.:([a-z0-9_]+[?!]?)/, '.method(:\1)').
        gsub(/\.!([a-z0-9_]+[?!]?)([ \(])(?=(.*))/) { ".send#{$2}:#{$1}#{$3 == ""?"":","}".tap &method(:puts) }
  end
end
