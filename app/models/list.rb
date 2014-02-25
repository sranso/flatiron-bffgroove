class List < ActiveRecord::Base
  attr_accessible :name, :list_id

  def self.import_lists
    api = MailChimpCrawler.new
    response = api.all_lists
    response.each do |list|
      current_list = find_by_list_id(list["id"]) || new
      current_list[:list_id] = list["id"]
      current_list[:name] = list["name"]
      current_list.save!
    end
  end 
end
