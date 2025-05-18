class PropertiesController < ApplicationController
  def index
    @published_since_options = published_since_options
    filter_params = params.permit(:bedrooms, :bathrooms, :size, :published_at, :sold, price: [], property_type: []).to_h.symbolize_keys

    validate_price_filter(filter_params)
    validate_property_type_filter(filter_params)
    validate_bedrooms_filter(filter_params)
    validate_published_at_filter(filter_params)

    filter_params.compact_blank!

    @properties = Property.filter(filter_params).results
  end

  private

  def validate_price_filter(filter_params)
    return unless filter_params[:price].present?

    if filter_params[:price].all?(&:blank?)
      filter_params.delete(:price)
    else
      min_price = filter_params[:price][0]
      max_price = filter_params[:price][1]

      filter_params[:price] = [min_price.presence || 0, max_price.presence || 1_000_000_000]
    end
  end

  def validate_property_type_filter(filter_params)
    return unless filter_params[:property_type].present?

    if filter_params[:property_type].any?(&:blank?)
      filter_params.delete(:property_type)
    else
      filter_params[:property_type] = filter_params[:property_type].map(&:to_sym)
    end
  end

  def validate_bedrooms_filter(filter_params)
    return unless filter_params[:bedrooms].present?

    bedroom_ranges = [0, 99]

    case filter_params[:bedrooms]
    when 't0_t1' then bedroom_ranges = [0, 1]
    when 't2_t3' then bedroom_ranges = [2, 3]
    when 't4_plus' then bedroom_ranges = [4, 99]
    end

    filter_params[:bedrooms] = [bedroom_ranges.min - 1, bedroom_ranges.max + 1]
  end

  def validate_published_at_filter(filter_params)
    return unless filter_params[:published_at].present?

    filter_params[:published_at] = Time.at(filter_params[:published_at].to_i).to_datetime
  end

  def published_since_options
    {
      "Any time" => "",
      "Last 48 hours" => 48.hours.ago.beginning_of_hour.to_i,
      "Last week" => 1.week.ago.beginning_of_day.to_i,
      "Last month" => 1.month.ago.beginning_of_day.to_i
    }.transform_values(&:to_s)
  end
end
