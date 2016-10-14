require 'rails_helper'

RSpec.describe Booking, type: :model do

  context "A partially overlaps B" do
    it "should return false" do

    end
  end

  context "A surrounds B" do
    it "should return false" do

    end
  end

  context "B surround A" do
    it "should return false" do

    end
  end

  context "A occurs entirely after B" do
    it "should return true" do

    end
  end

  context "B occurs entirely after A" do
    it "should return true" do

    end
  end
end
