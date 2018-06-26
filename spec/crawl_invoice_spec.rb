require_relative '../crawl_invoice'

RSpec.describe "crawl invoices service" do
    context "when service is online" do
        it "get 200 response code" do
            crawl_invoice = CrawlInvoice.new("4e25ce61-e6e2-457a-89f7-116404990967")
            prueba = crawl_invoice.get_total_invoices("2017-01-1","2017-12-31")
            expect(prueba).to be_success
        end
    end
end