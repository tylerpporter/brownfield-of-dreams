require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  it {should have_many(:videos).dependent(:destroy)}
end
