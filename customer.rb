require_relative 'crawl_invoice'

class Customer
  def initialize(customer_id)
    @customer_id = customer_id
  end

  def crawling_cutomer_total_invoices(date_init, date_fin)
    isFinish = false
    date_init_arr = date_init.split("-")
    date_fin_arr = date_fin.split("-")
    date_init = Time.new(date_init_arr[0], date_init_arr[1], date_init_arr[2])
    date_fin = Time.new(date_fin_arr[0], date_fin_arr[1], date_fin_arr[2])

    date_init_timestamp = date_init.to_i
    date_fin_timestamp = date_fin.to_i
    calls = 0

    crawl_invoice = CrawlInvoice.new(@customer_id)
    while !isFinish
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

      calls += 1
      total_invoices = crawl_invoice.get_total_invoices(new_date_init_str,
                                                        new_date_fin_str).body

      if total_invoices.include?("resultados")
        date_fin_timestamp = medium
      else
        #p "Resultados #{total_invoices} from #{new_date_init_str} to #{new_date_fin_str}"
        date_init_timestamp = date_fin_timestamp
        date_fin_timestamp = date_fin.to_i
      end

      if new_date_init.to_i >= date_fin.to_i
        isFinish = true
      end

    end
    calls
  end
end


