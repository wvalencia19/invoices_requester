require_relative 'crawl_invoice'

class Customer
  SECONDS_DAY = 86400

  def initialize(customer_id)
    @customer_id = customer_id
  end

  def binary_crawling_invoices(date_init, date_fin)
    date_init_arr = date_init.split("-")
    date_fin_arr = date_fin.split("-")
    date_init = Time.new(date_init_arr[0], date_init_arr[1], date_init_arr[2])
    date_fin = Time.new(date_fin_arr[0], date_fin_arr[1], date_fin_arr[2])
    date_init_timestamp = date_init.to_i
    date_fin_timestamp = date_fin.to_i
    calls = 0
    total_invoices = 0
    crawl_invoice = CrawlInvoice.new(@customer_id)
    while true
      medium = date_init_timestamp + ((date_fin_timestamp - date_init_timestamp) / 2)

      new_date_init = Time.at(date_init_timestamp)
      new_year_init = new_date_init.year
      new_month_init = new_date_init.month
      new_day_init = new_date_init.day
      new_date_init_str = "#{new_year_init}-#{new_month_init}-#{new_day_init}"

      new_date_fin = Time.at(date_fin_timestamp)
      new_year_fin = new_date_fin.year
      new_month_fin = new_date_fin.month
      new_day_fin = new_date_fin.day
      new_date_fin_str = "#{new_year_fin}-#{new_month_fin}-#{new_day_fin}"

      if new_date_init.to_i >= date_fin.to_i
        break
      end

      invoices = crawl_invoice.get_total_invoices(new_date_init_str,
                                                  new_date_fin_str).body
      calls += 1

      if invoices.include?("resultados")
        date_fin_timestamp = medium
      else
        date_init_timestamp = date_fin_timestamp
        date_init_timestamp += SECONDS_DAY
        date_fin_timestamp = date_fin.to_i
        total_invoices += invoices.to_i
      end
    end
    return calls, total_invoices
  end

  def crawling_cutomer_total_invoices(date_init_str, date_fin_str)
    date_init_arr = date_init_str.split("-")
    date_fin_arr = date_fin_str.split("-")
    date_init = Time.new(date_init_arr[0], date_init_arr[1], date_init_arr[2]).to_date
    date_fin = Time.new(date_fin_arr[0], date_fin_arr[1], date_fin_arr[2]).to_date
    total_calls = 0
    total_invoices = 0
    last_month_days = (date_init..date_fin).select {|d| d.day == 1}.map {|d| d - 1}

    # First call
    calls, invoices = binary_crawling_invoices(date_init_str, last_month_days[0].to_s)
    total_calls += calls
    total_invoices += invoices

    for i in  0...last_month_days.size - 1
      calls, invoices =binary_crawling_invoices((last_month_days[i] + 1).to_s, last_month_days[i+1].to_s)
      total_calls += calls
      total_invoices += invoices
    end

    # Last call
    calls, invoices = binary_crawling_invoices((last_month_days[-1] + 1).to_s, date_fin_str)
    total_calls += calls
    total_invoices += invoices

    p total_calls
    p total_invoices

  end
end

