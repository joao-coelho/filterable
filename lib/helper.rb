module Filterable
  module Helper
    class << self
      def find_filter_name(type, field)
        article = {
          range: 'bt',
          excl_range: 'bte',
          gt: 'gt',
          gt_or_eq: 'gte',
          lt: 'lt',
          lt_or_eq: 'lte',
          list: 'in',
          enum_list: 'in',
          match: 'eq',
          not: 'not'
        }

        "with_#{field}_#{article[type]}"
      end

      def find_filter_query(type, field, value)
        case type
        when :range
          ["#{field} BETWEEN ? AND ?", value.first, value.last]
        when :excl_range
          ["#{field} > ? AND #{field} < ?", value.first, value.last]
        when :gt
          ["#{field} > ?", value]
        when :gt_or_eq
          ["#{field} >= ?", value]
        when :lt
          ["#{field} < ?", value]
        when :lt_or_eq
          ["#{field} <= ?", value]
        when :list, :enum_list
          value.one? ? ["#{field} = ?", value.first] : ["#{field} IN (?)", value]
        when :match
          ["#{field} = ?", value]
        when :not
          ["#{field} <> ?", value]
        end
      end
    end
  end
end
