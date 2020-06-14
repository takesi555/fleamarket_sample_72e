# README

## versions
rails:5,2,4,3
ruby:2.5.1p57
mysql:ver 14.14 Distrib 5.6.47

## tables

###Users table

|Colummn|type|Optionals|
|-------|----|---------|
|nickname|string|null:false|
|password|string|null:false|
|email|string|null:false|
|first_name|string|null:false|
|last_name|string|null:false|
|tel|string|null:false|
|birth|date|null:false|
|description|text||

####Association
- has_many:items
- has_many:creditcards
- has_many:destination

###Items table

|Colummn|type|Optionals|
|-------|----|---------|
|name|string|null:false|
|price|integer|null:false|
|description|text||
|closed_time|timestamp||
|buyer_id|bigint||
|prefecture_id|references|null:fale,foreign_key:true|
|category_id|references|null:false,foreign_key:true|
|brand_id|references|null:false,foreign_key:true|
|size_id|references|null:false,foreign_key:true|
|contition_id|references|null:false,foreign_key:true|

####Association
- belongs_to:user,dependent:destroy
- has_many:itemimages
- has_one:prefecture
- has_one:category
- has_one:brand
- has_one:size
- has_one:condition
- has_one:postage

###CreditCards table

|Colummn|type|Optionals|
|-------|----|---------|
|user_id|references|null:false,foreign_key:true|
|payjp_custumer_id|string|null:false|
|payjp_card_id|string|null:false|

####Association
- belongs_to:user,dependent:destroy

###Destinations table

|Colummn|type|Optionals|
|-------|----|---------|
|user_id|references|null:false,foreign_key:true|
|post_code|string|null:false|
|prefecture_id|string|null:false,foreign_key:true|
|city|string|null:false|
|block_num|string||
|first_name|string|null:false|
|last_name|string|null:false|

####Association
- belongs_to:user,dependent:destroy
- has_one:prefecture

###Prefectures table/Active_hash

|Colummn|type|Optionals|
|-------|----|---------|
|name|string|null:false|

####Association
-has_many:destinations
- has_many:items

###ItemImages table

|Colummn|type|Optionals|
|-------|----|---------|
|item_id|references|null:false,foreign_key:true|
|image|string|null:false|

####Association
- belongs_to:item,dependent:destroy

###Categories table/Active_hash

|Colummn|type|Optionals|
|-------|----|---------|
|name|string|null:false|
|mother|string||

####Association
- has_many:items

###Brands table/Active_hash


|Colummn|type|Optionals|
|-------|----|---------|
|name|string|null:false|

####Association
- has_many:items

###Sizes table/Active_hash

|Colummn|type|Optionals|
|-------|----|---------|
|grade|string|null:false|

####Association
-has_many:item

###Conditions table/Active_hash

|Colummn|type|Optionals|
|-------|----|---------|
|status|string|null:false|

####Association
- has_many:item

###Preperations table/Active_hash

|Colummn|type|Optionals|
|-------|----|---------|
|type|string|null:false|

####Association
- has_many:item

### Postages table/Active_hash

|Colummn|type|Optionals|
|-------|----|---------|
|type|string|null:false|

####Association
- has_many:itme
