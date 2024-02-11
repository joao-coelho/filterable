module FilterableHelper
  class << self
    def find_filter_name(type, field)
      article = {
        range: 'between',
        list: 'in',
        enum_list: 'in',
        match: 'of'
      }

      "with_#{field}_#{article[type]}"
    end

    def find_filter_query(type, field, value, klass)
      case type
      when :range
        "#{field} BETWEEN #{value.first} AND #{value.last}"
      when :list
        value.one? ? "#{field} = #{value.first}" : "#{field} IN (#{value.join(',')})"
      when :enum_list
        value.one? ? "#{field} = #{klass.send(field.to_s.pluralize)[value.first]}" : "#{field} IN (#{value.map { |enum_value| klass.send(field.to_s.pluralize)[enum_value] }.join(', ')})"
      when :match
        "#{field} = #{value}"
      end
    end
  end
end
