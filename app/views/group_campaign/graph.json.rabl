collection @weekdays
node :weekday do |m|
  m
end

# sorted_temp = []
# sorted_final = []

# @group_campaigns.each do |group_campaign|
#   sorted_final = (sorted_temp << group_campaign[@yaxis]).sort.reverse
#   sorted_final.each do |num|
#     if num == group_campaign[@yaxis]
#       group_campaign[@yaxis]
#     end
#   end
# end

@group_campaigns.each do |group_campaign|
  node(group_campaign.title.to_sym, :if => lambda {|m| group_campaign.send_weekday == m}) do
    group_campaign[@yaxis]
  end
  
end

# (rdb:6) node
# [{:name=>:weekday, :options=>{}, :block=>#<Proc:0x000001059b55b8@(eval):2>}, {:name=>:"Free Shipping Friday", :options=>{:if=>#<Proc:0x000001059b5478@(eval):19 (lambda)>}, :block=>#<Proc:0x000001059b5428@(eval):19>}, {:name=>nil, :options=>{}, :block=>nil}]
# (rdb:6) node[1][:block].call
#<BigDecimal:1036f85c0,'0.2268087E5',18(45)>
# (rdb:6) node[1][:block].call.to_f
# 22680.87

# What you want to do is sort first then find each campaign with that value make a 
# node and assign it to it