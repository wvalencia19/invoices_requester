require_relative 'customer'

custormer_id = ARGV[0]
date_init = ARGV[1]
date_fin = ARGV[2]

customer = Customer.new(custormer_id)

calls, invoices = customer.crawling_cutomer_total_invoices(date_init,
                                         date_fin)

p "Found #{invoices} invoices in #{calls} calls for customer #{custormer_id}"