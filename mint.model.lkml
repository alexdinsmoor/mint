connection: "ad_personal_bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

datagroup: daily {
  max_cache_age: "168 hours"
  sql_trigger: select count(*) from `devops-learning-274418.mint.mint_transactions` ;;
}

explore: mint_transactions  {
  group_label: "Mint Data"

  sql_always_where: ${category} not in ('Transers','Hide from Budgets & Trends', 'Credit Card Payment')
  and (LOWER(${description}) not like '%autopay%' AND  LOWER(${description}) not like '%epay%') ;;

  always_filter: {
    filters: [
      date_date: "Last 730 Days"
    ]
  }

}
