# frozen_string_literal: true

require 'rails_helper'

describe 'ActiveSupport::ParameterFilter' do
  let(:config) { I14y::Application.config }
  let(:parameter_filter) { ActiveSupport::ParameterFilter.new(config.filter_parameters) }

  it 'filters query from logs' do
    # expect(config.filter_parameters).to match(array_including(:query))
    puts config.filter_parameters.to_s
    expect(config.filter_parameters.to_s).to match(/:query/)
  end
end
