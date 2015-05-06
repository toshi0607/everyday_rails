require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone number per contact" do
    contact = Contact.create(firstname: 'Joe', lastname: 'Tester',
      email: 'joetester@example.com')
    home_phone = contact.phones.create(phone_type: 'home',
      phone: '785-555-1234')
    mobile_phone = contact.phones.build(phone_type: 'mobile',
      phone: '785-555-1234')

    expect(mobile_phone).to have(1).errors_on(:phone)
  end

  it "allows two contacts to share a phone number" do
    create(:phone,
      phone_type: 'home',
      phone: "785-555-1234")
    expect(build(:phone,
      phone_type: 'home',
      phone: "785-555-1234")).to be_valid
  end
end