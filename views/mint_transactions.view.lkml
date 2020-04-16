view: mint_transactions {
  sql_table_name: `devops-learning-274418.mint.mint_transactions`
    ;;

## BASE DIMENSIONS ##

  dimension: account_name {
    hidden: yes
    type: string
    sql: ${TABLE}.Account_Name ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.Amount ;;
    value_format_name: usd
  }

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  dimension_group: date {
    label: "Transaction"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }

  dimension: description {
    hidden: yes
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: original_description {
    hidden: yes
    type: string
    sql: ${TABLE}.Original_Description ;;
  }


  dimension: transaction_type {
    type: string
    sql: ${TABLE}.Transaction_Type ;;
  }


## ADDN'L DIMENIONS ##

  dimension: description_case_adj {
    label: "Description"
    type: string
    sql: lower(${description}) ;;
  }

  dimension: full_description_case_adj {
    label: "Full Description"
    type: string
    sql: lower(${original_description}) ;;
  }

  dimension: account_name_case_adj {
    label: "Account Name"
    type: string
    sql: lower(${account_name}) ;;
  }

  dimension: modified_amount  {
    label: "Cash Flow Amount"
    type: number
    sql: CASE WHEN ${transaction_type} = 'debit' THEN (-1.0)*${amount} ELSE ${amount} END ;;
    value_format_name: usd
  }

  dimension: is_income {
    hidden: yes
    type: yesno
    sql: ${category} in ('Income', 'Paycheck') ;;
  }

  dimension: is_tax_refund {
    hidden: yes
    type: yesno
    sql: ${category} in ('Federal Tax', 'State Tax') ;;
  }

## MEASURES ##

  measure: transaction_count {
    type: count
    drill_fields: [account_name]
  }

  measure: total_cash_flow {
    label: "Total Cash Flow"
    type: sum
    sql: ${modified_amount} ;;
    value_format_name: usd_0
    drill_fields: [category, transaction_type, total_cash_flow, total_amount]
  }

  measure: total_amount {
    type: sum
    sql: ${amount} ;;
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }

  measure: average_amount {
    type: average
    sql: ${amount} ;;
    value_format_name: usd
    drill_fields: [transaction_details*]
  }

  measure: total_income {
    type: sum
    sql: ${amount} ;;
    filters: [is_income: "Yes"]
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }

  measure: total_tax_refunds {
    type: sum
    sql: ${amount} ;;
    filters: [is_tax_refund: "Yes"]
    value_format_name: usd_0
    drill_fields: [transaction_details*]
  }


## DRILLS ##

  set: transaction_details {
    fields: [
      account_name
      , category
      , description
      , transaction_type
      , date_date
      , modified_amount
    ]
  }

}
