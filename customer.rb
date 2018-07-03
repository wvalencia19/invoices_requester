require_relative 'crawl_invoice'
require_relative 'searcher'

class Customer
  attr_reader :searcher
  SECONDS_DAY = 86400

  def initialize(customer_id)
    @customer_id = customer_id
    crawl_invoice = CrawlInvoice.new
    @searcher = Searcher.new(crawl_invoice)
  end

  def crawling_cutomer_total_invoices(date_init_str, date_fin_str)
    date_init_arr = date_init_str.split("-")
    date_fin_arr = date_fin_str.split("-")
    date_init = Time.new(date_init_arr[0],
                         date_init_arr[1],
                         date_init_arr[2]).to_date
    date_fin = Time.new(date_fin_arr[0],
                        date_fin_arr[1],
                        date_fin_arr[2]).to_date
    total_calls = 0
    total_invoices = 0
    calls = 0
    invoices = 0
    last_month_days = (date_init..date_fin).select {|d| d.day == 1}.map {|d| d - 1}

    if are_same_month_dates?(date_init, date_fin)
      return @searcher.binary_crawling_invoices(@customer_id,
                                             date_init.to_time.to_i,
                                             date_fin.to_time.to_i)
    end

    total_calls += calls
    total_invoices += invoices

    for i in  0...last_month_days.size - 1
      calls, invoices = @searcher.binary_crawling_invoices(@customer_id,
                                                        (last_month_days[i] + 1).to_time.to_i,
                                                        last_month_days[i+1].to_time.to_i)
      total_calls += calls
      total_invoices += invoices
    end

    calls, invoices = @searcher.binary_crawling_invoices(@customer_id,
                                                      (last_month_days[-1] + 1).to_time.to_i,
                                                      date_fin.to_time.to_i)
    total_calls += calls
    total_invoices += invoices

    return total_calls, total_invoices
  end

  private
  def are_same_month_dates?(date_init, date_fin)
    "#{date_init.year}#{date_init.month}" == "#{date_fin.year}#{date_fin.month}"
  end
end

