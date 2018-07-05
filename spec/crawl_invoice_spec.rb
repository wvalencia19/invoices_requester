require_relative '../crawl_invoice'

RSpec.describe "crawl invoices service" do
  before do
    @passenger_id = "4e25ce61-e6e2-457a-89f7-116404990967"
    @date_init = "2017-01-1"
    @date_fin = "2017-12-31"
  end

  context "when service is online" do
    it "get 200 response code" do
      crawl_invoice = CrawlInvoice.new
      response = crawl_invoice.get_total_invoices(@passenger_id,
                                                  @date_init,
                                                  @date_fin)
      expect(response).to be_success
    end
  end
end