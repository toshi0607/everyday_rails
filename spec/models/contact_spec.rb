require 'spec_helper'
describe Contact do

  it "has a valid factory" do
    expect(FactoryGirl.build(:contact)).to be_valid
  end

  it "is invalid without a firstname" do
    contact = FactoryGirl.build(:contact, firstname: nil)
    expect(contact).to have(1).errors_on(:firstname)
  end

  it "is invalid without a lastname" do
    contact = FactoryGirl.build(:contact, lastname: nil)
    expect(contact).to have(1).errors_on(:lastname)
  end

  it "is invalid without an email address" do
    contact = FactoryGirl.build(:contact, email: nil)
    expect(contact).to have(1).errors_on(:email)
  end

  it "is invalid with a duplicate email address" do
    FactoryGirl.create(:contact, email:"aaron@example.com")
    contact = FactoryGirl.build(:contact, email: "aaron@example.com")
    expect(contact).to have(1).errors_on(:email)
  end

  it "returns a contact's full name as a string" do
    contact = FactoryGirl.build(:contact, firstname: 'Jane', lastname: 'Doe')
    expect(contact.name).to eq 'Jane Doe'
  end

  describe "filter last name by letter" do
    before :each do
      @smith = Contact.create(firstname: 'John', lastname: 'Smith',
        email: 'jsmith@example.com')
      @jones = Contact.create(firstname: 'Tim', lastname: 'Jones',
        email: 'tjones@example.com')
      @johnson = Contact.create(firstname: 'John', lastname: 'Johnson',
        email: 'jjohnson@example.com')
    end
    context "matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter('J')).to eq [@johnson, @jones]
      end
    end

    context "non-matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to_not include @smith
      end
    end
  end
end