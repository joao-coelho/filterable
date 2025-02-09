require 'active_support/concern'

module Filterable
  extend ActiveSupport::Concern

  def self.included(base)
    querier = Class.new do
      def initialize(initial_scope, params)
        @builder = initial_scope
        @params  = params
      end

      def results(all_filters: true)
        if all_filters
          @params.each_with_index do |(attr, value), index|
            method_name = FilterableHelper.find_filter_name(self.class.module_parent.filters[attr], attr)
            log_str = '-' * (index + 1)

            puts "#{log_str}> Executing filter '#{method_name}(#{value})'"
            send(method_name)
          end
        end

        @builder
      end

      base.filters.each do |field, type|
        define_method FilterableHelper.find_filter_name(type, field) do
          value =
            if type == :enum_list
              enum = base.send(field.to_s.pluralize)

              @params[field].map { |val| enum[val] }
            else
              @params[field]
            end

          @builder = @builder.where(FilterableHelper.find_filter_query(type, field, value))

          self
        end
      end
    end

    base.class_eval do
      const_set(:FilterQuerier, querier)

      def self.filter(params, includes = nil)
        if params.blank?
          puts '[ERROR]: No params were provided'
        else
          self::FilterQuerier.new(self, params)
        end
      end
    end
  end
end
