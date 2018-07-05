require_relative '../searcher'
require_relative '../crawl_invoice'

RSpec.describe "searcher" do
  before do
    @passenger_id = "4e25ce61-e6e2-457a-89f7-116404990967"
    @date_init = 1483246800
    @date_fin = 1514696400
  end

  context "when request returns less than 100 invoices" do
    it "calls must be equal to 1" do
      crawler_response = double(:crawler_response, body: "40")
      crawl_invoice = CrawlInvoice.new
      searcher = Searcher.new(crawl_invoice)
      expect(crawl_invoice).to receive(:get_total_invoices)
                               .once.and_return(crawler_response)
      searcher.binary_crawling_invoices(@passenger_id,
                                        @date_init,
                                        @date_fin)
    end
  end

  context "when date init is greather tan date fin" do
    it "calls must be equal to 0" do
      crawl_invoice = CrawlInvoice.new
      searcher = Searcher.new(crawl_invoice)
      expect(crawl_invoice).to receive(:get_total_invoices)
                               .exactly(0).times
      searcher.binary_crawling_invoices(@passenger_id,
                                        @date_fin,
                                        @date_init)
    end
  end
end