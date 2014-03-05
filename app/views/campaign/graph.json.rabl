# WEEKDAYS
# collection @weekdays
# node :variable do |m|
#   m
# end

# @campaigns.each do |campaign|
#   node(campaign.title.to_sym, :if => lambda {|m| campaign.send_weekday == m}) do
#     campaign[@yaxis]
#   end
# end

# TIMES OF DAY
collection @times
node :variable do |m|
  m
end

@campaigns.each do |campaign|
  node(campaign.title.to_sym, :if => lambda do |m|
    m.split(" ").include? campaign.send_date.strftime("%l%p").strip
  end) do
    campaign[@yaxis]
  end
end