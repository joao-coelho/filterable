module FilterableHelper
  class << self
    def find_filter_name(type, field)
      article = {
        range: 'between',
        list: 'in',
        match: 'of'
      }

      "with_#{field}_#{article[type]}"
    end

    def find_filter_query(type, field, value)
      case type
      when :range
        "#{field} BETWEEN #{value.first} AND #{value.last}"
      when :list
        value.one? ? "#{field} = #{value.first}" : "#{field} IN (#{value.join(',')})"
      when :match
        "#{field} = #{value}"
      end
    end
  end
end
