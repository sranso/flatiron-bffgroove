collection @weekdays
node :weekday do |m|
  m
end

sorted_temp = []
sorted_final = []

@group_campaigns.each do |group_campaign|
  sorted_final = (sorted_temp << group_campaign[@yaxis].to_i).sort.reverse
  node(group_campaign.title.to_sym, :if => lambda {|m| group_campaign.send_weekday == m}) do
    sorted_final.each do |num|
      if num == group_campaign[@yaxis].to_i
        group_campaign[@yaxis].to_i
      end
    end
  end
  
end
# What you want to do is sort first then find each campaign with that value make a 
# node and assign it to it