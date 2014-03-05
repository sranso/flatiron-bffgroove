# TIMES OF DAY
collection @xaxis
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