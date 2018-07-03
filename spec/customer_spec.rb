require_relative '../customer'
require_relative '../searcher'

RSpec.describe "customer crawl invoices" do
  before do
    @customer = Customer.new("4e25ce61-e6e2-457a-89f7-116404990967")
  end

  context "when requests total invoices for one year" do
    it "total invoices greater than zero" do
      calls, invoices = @customer.crawling_cutomer_total_invoices("2017-01-1",
                                                                  "2017-12-31")
      expect(invoices).to eq 1173
      expect(calls).to eq 18
    end
  end

  context "when request invoices for one month" do
    it "get total invoices" do
      calls, invoices = @customer.crawling_cutomer_total_invoices("2017-02-1",
                                                                  "2017-02-28")
      expect(invoices).to be > 0
      expect(calls).to be > 0
    end
  end

  context "when request invoices for different years" do
    it "get total invoices" do
      calls, invoices = @customer.crawling_cutomer_total_invoices("2016-10-1",
                                                                  "2017-3-15")
      expect(invoices).to be > 0
      expect(calls).to be > 0
    end
  end

  context "when request returns less than 100 invoices" do
    it "calls must be equal to 1" do
      calls, invoices = @customer.crawling_cutomer_total_invoices("2017-1-1",
                                                                  "2017-1-15")
      expect(invoices).to be < 100
      expect(calls).to eq  1
    end
  end

  context "when request returns more thant 100 invoices" do
    it "calls must be greater to 2" do
      calls, invoices = @customer.crawling_cutomer_total_invoices("2017-1-1",
                                                                  "2017-3-15")
      expect(invoices).to be > 100
      expect(calls).to be > 2
    end
  end
end

RSpec.describe "mock customer crawl invoices" do
  before do
    @double_invoices = 10
    @double_calls = 1
    @customer = Customer.new("4e25ce61-e6e2-457a-89f7-116404990967")
  end

  context "when request invoices for one month" do
    it "get total invoices" do
      times = 3
      expect(@customer.searcher).to receive(:binary_crawling_invoices)
                                .exactly(times).times
                                .and_return([@double_calls, @double_invoices])
      calls, invoices = @customer.crawling_cutomer_total_invoices("2017-1-1",
                                                                  "2017-3-30")
      expect(invoices).to eq @double_invoices * times
      expect(calls).to eq  @double_calls * times
    end
  end

  context "when request invoices for different years" do
    it "get total invoices" do
      times = 2
      expect(@customer.searcher).to receive(:binary_crawling_invoices)
                                    .exactly(times).times
                                    .and_return([@double_calls, @double_invoices])
      calls, invoices = @customer.crawling_cutomer_total_invoices("2016-12-1",
                                                                  "2017-1-1")
      expect(invoices).to eq @double_invoices * times
      expect(calls).to eq  @double_calls * times
    end
  end

  context "when requests total invoices for one year" do
    it "get total invoices" do
      times = 12
      expect(@customer.searcher).to receive(:binary_crawling_invoices)
                                    .exactly(times).times
                                    .and_return([@double_calls, @double_invoices])
      calls, invoices = @customer.crawling_cutomer_total_invoices("2017-1-1",
                                                                  "2017-12-31")
      expect(invoices).to eq @double_invoices * times
      expect(calls).to eq  @double_calls * times
    end
  end
end