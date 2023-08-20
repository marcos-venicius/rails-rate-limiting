class FooController < ApplicationController
  def index
    render json: { foor: :bar }
  end
end
