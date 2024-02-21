Table product {
  name varchar [primary key]
  coffea varchar
  varietal varchar
  origin varchar
  roasting_type varchar
  decaf bool
  marketing_format varchar 
}

Table reference {
  barcode varchar [primary key]
  packing_description varchar
  retail_price varchar
  stock int
}

Table replacementOrder {
  id int [primary key]
  provider varchar
  amount int
  order_date date
  order_time time
  order_status varchar
  receive_date date
  total_payment float() // maybe include number of decimal places
}

Table provider {
  name varchar [primary key, unique]
  tax_id int
  salesperson_name varchar [unique]
  email varchar [unique]
  phone_number int [unique]
  commercial_address varchar [unique]
}

Table customerOrder {
  date date
  delivery_address varchar
  payment_type varchar // either cash on delivery, bank transfer, credit card
  payment_date date
  credit_card int
}
