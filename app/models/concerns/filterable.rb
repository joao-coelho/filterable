require 'active_support/concern'

module Filterable
  extend ActiveSupport::Concern

  def self.included(base)
    querier = Class.new do
      def initialize(initial_scope, params)
        @builder = initial_scope
        @params  = params
      end

      base.filters.each do |field, type|
        define_method FilterableHelper.find_filter_name(type, field) do
          @builder = @builder.where(FilterableHelper.find_filter_query(type, field, @params[field]))

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
