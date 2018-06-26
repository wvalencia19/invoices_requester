require_relative '../customer'

RSpec.describe "customer invoices" do
  context "when request total invoice" do
    it "total invoices greater than zero" do
      customer = Customer.new("4e25ce61-e6e2-457a-89f7-116404990967")
      invoices = customer.crawling_cutomer_total_invoices("2017-01-1", "2017-12-31")
      expect(invoices).to be > 0
    end
  end
end