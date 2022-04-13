class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    # Send the show view (and ultimately, the line_item partial) an array containing hashes
    enhanced_line_items
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

  # create a hash for each line_item in an order
  # the hash contains the product for that line_item and the line_item data
  def enhanced_line_items
    # get all line_items for an order
    @line_items = LineItem.where(order_id: @order.id)
    # create an array of hashes, each containing data from product and line_item
    @enhanced_line_items = @line_items.map { |line_item|  
    # create a hash containing data to be sent to the partial 'line_item'
    {
        # find the product for this line item
        product: Product.find(line_item[:product_id]),
        quantity: line_item[:quantity].to_i,
        total_price: line_item[:total_price_cents] / 100.0
      }
    }
  end

end
