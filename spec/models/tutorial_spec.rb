require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  it {should have_many(:videos).dependent(:destroy)}
  
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  it {should validate_presence_of(:thumbnail)}
end
