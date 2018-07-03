require 'httparty'

class CrawlInvoice
  SERVER_HOST = '34.209.24.195'
  include HTTParty
  base_uri SERVER_HOST

  def get_total_invoices(id, init_date, fin_date)
    options = {query: {id: id, start: init_date, finish: fin_date}}
    self.class.get("/facturas", options)
  end
end

