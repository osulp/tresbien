class AddVendorPaymentAddressToOrganization < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :vendor_payment_address, :string
  end
end
