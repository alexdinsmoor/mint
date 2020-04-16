view: mint_investments {
  sql_table_name: `devops-learning-274418.mint.mint_investments`
    ;;

  dimension: change {
    type: number
    sql: ${TABLE}.CHANGE ;;
  }

  dimension_group: date_checked {
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
    sql: ${TABLE}.DATE_CHECKED ;;
  }

  dimension: mkt__value {
    type: number
    sql: ${TABLE}.MKT__VALUE ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.PRICE ;;
  }

  dimension: price_paid {
    type: number
    value_format_name: id
    sql: ${TABLE}.PRICE_PAID ;;
  }

  dimension: shares {
    type: number
    sql: ${TABLE}.SHARES ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
