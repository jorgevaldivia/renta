class OpenPay::Base
  attr :resource
  attr :client
  attr :customer_id

  # Initialize and setup the client using env vars.
  def initialize(customer_id=nil)
    @customer_id = customer_id
    @client = OpenpayApi.new(ENV["OPEN_PAY_MERCHANT_ID"], ENV["OPEN_PAY_PRIVATE_KEY"])
    # resource_name is defined in child classes.
    @resource = @client.create(resource_name)
  end

  # If record is new, create it, otherwise, update it.
  def save(attrs)
    if attrs[:id].present?
      data = @resource.update(attrs, @customer_id)
    else
      attrs.delete(:id) 
      if resource_name == :customers
        data = @resource.create(attrs)
      else
        data = @resource.create(attrs, @customer_id)
      end
    end

    data.merge({"open_pay_id" => data["id"]})
  end

  def destroy(id)
    if resource_name == :customers
      @resource.delete(id)
    else
      @resource.delete(@customer_id, id)
    end
  end

  private

  def resource_name
    raise NotImplementedError
  end
end