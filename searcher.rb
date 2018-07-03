class Searcher

  def initialize(crawl_invoice)
    @crawl_invoice = crawl_invoice
  end

  def binary_crawling_invoices(customer_id, date_init, date_fin)

    return 0, 0 if date_fin < date_init

    calls = 0
    total_invoices = 0
    origin_fin = date_fin
    while true
      medium = date_init + ((date_fin - date_init) / 2)

      new_date_init = Time.at(date_init)
      new_year_init = new_date_init.year
      new_month_init = new_date_init.month
      new_day_init = new_date_init.day
      new_date_init_str = "#{new_year_init}-#{new_month_init}-#{new_day_init}"

      new_date_fin = Time.at(date_fin)
      new_year_fin = new_date_fin.year
      new_month_fin = new_date_fin.month
      new_day_fin = new_date_fin.day
      new_date_fin_str = "#{new_year_fin}-#{new_month_fin}-#{new_day_fin}"

      if new_date_init.to_i >= origin_fin
        break
      end

      invoices = @crawl_invoice.get_total_invoices(customer_id,
                                                   new_date_init_str,
                                                   new_date_fin_str).body

      calls += 1
      if invoices.include?("resultados")
        date_fin = medium
      else
        date_init = date_fin
        date_init += 86400
        date_fin = origin_fin
        total_invoices += invoices.to_i
      end
    end
    return calls, total_invoices
  end
end
