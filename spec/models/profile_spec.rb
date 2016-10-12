require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe "#by_letter" do

    subject { Profile.by_letter("S") }
    let(:profile1) { create :profile, first_name: "Sander" }
    let(:profile2) { create :profile, first_name: "Stefan" }
    let(:profile3) { create :profile, first_name: "Wouter" }
    let(:profile4) { create :profile, first_name: "Daniel" }

    context "matching letters" do
      it "returns a sorted array of results that match" do
        expect(subject).to match_array [profile1, profile2]
      end
    end

    context "non-matching letters" do
      it "does not return profiles that don't start with the given letter" do
        expect(subject).not_to include profile3
        expect(subject).not_to include profile4
      end
    end


  end
end
