GroupCampaign.all.each do |gc|
  # gc.title = /([^\.]+\.).*/.match(Random.paragraphs)[1]
  gc.campaigns.each_with_index do |c, i|
    # c.title = gc.title + " (copy #{i})"
    # c.subject = /([^\.]+\.).*/.match(Random.paragraphs)[1]
    # c.total_recipients = Random.number(280000)
    # c.successful_deliveries = (c.total_recipients - Random.number(10000)).abs
    # c.soft_bounces = Random.number(100)
    # c.hard_bounces = Random.number(100)
    # c.total_bounces = c.soft_bounces + c.hard_bounces
    c.times_forwarded = Random.number(10)
    # c.unique_opens = Random.number(50000)
    c.open_rate = c.unique_opens / c.successful_deliveries #
    # c.total_opens = c.unique_opens + Random.number(900)
    # c.unique_clicks = Random.number(3000)
    c.click_rate = c.unique_clicks / c.open_rate #
    # c.total_clicks = Random.number(5000)
    # c.unsubscribes = Random.number(500)
    # c.abuse_complaints = Random.number(100)
    # c.unique_id = Random.alphanumeric
    # c.revenue_created = Random.number(20000)
    # c.visits = Random.number(1000)
    c.new_visits = (c.visits - Random.number(100)).abs #
    # c.bounce_rate = Random.number(30) / 100.round(2)
    # c.transactions = Random.number(500)
    c.ecommerce_conversion_rate = Random.number(15) / 100.round(2) #
    c.save!
  end
  gc.save!
end

GroupCampaign.all.each do |gc|
  gc.title = gc.title.split(" ")[0..5].join(" ")
  gc.campaigns.each_with_index do |c, i|
    c.title = gc.title + " (copy #{i})"
    c.subject = c.subject.split(" ")[0..5].join(" ")
    c.save!
  end
  gc.save!
end

GroupCampaign.all.each do |gc|
  gc.title = gc.title.split(" ")[0..5].join(" ")
  gc.campaigns.each_with_index do |c, i|
    c.send_date = c.send_date
    c.save!
  end
  gc.save!
end