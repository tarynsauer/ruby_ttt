require 'spec_helper'

describe 'RubyTictactoe::GameSetup' do

  describe '#get_settings' do
    it 'returns hash with settings values' do
      @setup = RubyTictactoe::GameSetup.new
      @setup.get_settings.is_a?(Hash)
    end
  end

end