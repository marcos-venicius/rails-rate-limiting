require 'rails_helper'

RSpec.describe 'Application Requests', type: :request do
  before :each do
    REDIS.flushall
  end

  context 'testing rating limit' do
    it 'should return status 429 when exceds the max rating limit' do
      THROTTLE_MAX_REQUESTS.times.each do
        get foo_index_path
      end

      get foo_index_path

      expect(response.status).to eql(429)
    end

    it 'should return status 200 if the rate limiting only reaches the max' do
      (THROTTLE_MAX_REQUESTS - 1).times.each do
        get foo_index_path
      end

      get foo_index_path

      expect(response.status).to eql(200)
    end
  end
end