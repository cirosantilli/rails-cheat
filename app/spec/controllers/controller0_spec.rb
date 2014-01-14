require "spec_helper"

# Set this to true if you want to see what things are like when they fail.
do_fail = false

##describe

  # TODO can impact tests, or is it string description only?

  # Any object can be passed to describe, and the class being tested is often passed.

##it

  # Basic test unit.

  # The test fails if one should or expect to inside it fails.

describe "desc0" do
  describe "desc0_0" do
    it "passes" do
    end

    it "passes" do
      expect(1).to eq(1)
    end

    it "fails" do
      if do_fail
        expect(1).to eq(2)
      end
    end
  end

  describe "abc" do
    #it { should == "abc" }
    #it { should != "acb" }
  end

  it "should" do
    # Old and discoraged. Use expect to instead.

    # Insaner because added to every object.

    1.should eq(1)
    if do_fail
      1.should eq(2)
    end
  end

  it "expect" do

    ##eq

      # Calls `==`.

        expect(1).to eq(1)
        if do_fail
          expect(1).to eq(2)
        end

    # Cannot use operators with expect to:

        if do_fail
          expect(1).to == 1
        end

    ##be

      # TODO what does it do exactly? Seems to work for operators.

        expect(1).to be == 1

    ##define a matcher

        RSpec::Matchers.define :be_eq do |expected|
          match do |actual|
            actual == expected
          end
        end

        expect(1).to be_eq(1)
  end

    ##before ##after

      # Before and after can be used here just like in the spec_helper
      # but scoped to a single describe.

        before(:each) do
          @i = 0
        end

        it "i == 0" do
          expect(@i).to eq(0)
          @i = 1
        end

        it "i == 0" do
          expect(@i).to eq(0)
        end
end
