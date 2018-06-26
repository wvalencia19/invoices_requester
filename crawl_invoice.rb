require 'httparty'

class CrawlInvoice
  include HTTParty
  base_uri '34.209.24.195'

  def initialize(id)
        @id = id
  end

  def get_total_invoices(init_date, fin_date)
    options = { query: { id: @id, start: init_date, finish: init_date } }
    self.class.get("/facturas", options)
  end
end

