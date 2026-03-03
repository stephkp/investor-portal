class AddDocumentsToInvestors < ActiveRecord::Migration[7.1]
  def change
    add_column :investors, :documents, :json
  end
end
