# WEEKDAYS
collection @xaxis
node :variable do |m|
  m
end

@campaigns.each do |campaign|
  node(campaign.title.to_sym, :if => lambda {|m| campaign.send_weekday == m}) do
    campaign[@yaxis]
  end
end