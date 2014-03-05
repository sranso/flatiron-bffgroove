collection @weekdays
node :weekday do |m|
  m
end

@sorted_final.each_with_index do |value, i|
  @group_campaigns.each do |gc|
    if gc[@yaxis] == value
      node(gc.title.to_sym, :if => lambda {|m| gc.send_weekday == m}) do
        value
      end
    end
  end
  @sorted_final.delete_at(i)
end

# @group_campaigns.each do |group_campaign|
#   node(group_campaign.title.to_sym, :if => lambda {|m| group_campaign.send_weekday == m}) do
#     group_campaign[@yaxis]
#   end
# end