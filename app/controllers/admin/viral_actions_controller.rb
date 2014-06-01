class Admin::ViralActionsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @viral_actions = ViralAction.order("id desc").page(params[:page]).per(200)
    @viral_action_counts_daily = ViralAction.select(
      "date(convert_tz(viral_actions.created_at,'+00:00','+09:00')) as created_date,
      count(*) as total_count")
        .group("date(convert_tz(viral_actions.created_at,'+00:00','+09:00'))")
        .order("date(viral_actions.created_at)")
    @viral_action_counts_sum = ViralAction.select(
      "count(*) as total_count")
    @viral_platform_counts_daily = ViralAction.select(
      "date(convert_tz(viral_actions.created_at,'+00:00','+09:00')) as created_date,
      sum(case when viral_actions.platform = 'product1' then 1 else 0 end) as product1_count, 
    	sum(case when viral_actions.platform = 'product2' then 1 else 0 end) as product2_count, 
      sum(case when viral_actions.platform = 'product3' then 1 else 0 end) as product3_count, 
    	sum(case when viral_actions.platform = 'product4' then 1 else 0 end) as product4_count,
    	count(*) as total_count")
        .group("date(convert_tz(viral_actions.created_at,'+00:00','+09:00'))")
        .order("date(viral_actions.created_at)")
    @viral_platform_counts_sum = ViralAction.select(
      "sum(case when viral_actions.platform = 'product1' then 1 else 0 end) as product1_count, 
      sum(case when viral_actions.platform = 'product2' then 1 else 0 end) as product2_count, 
      sum(case when viral_actions.platform = 'product3' then 1 else 0 end) as product3_count, 
      sum(case when viral_actions.platform = 'product4' then 1 else 0 end) as product4_count, 
      count(*) as total_count") 
  end
end
