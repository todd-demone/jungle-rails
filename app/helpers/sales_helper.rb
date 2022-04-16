module SalesHelper

  def active_sale?
    @sales = Sale.active
    @sales.any?
  end

  def active_sales
    @sales = Sale.active
  end
  
end