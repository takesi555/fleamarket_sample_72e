# README

## versions
- rails:5,2,4,3
- ruby:2.5.1p57
- mysql:ver 14.14 Distrib 5.6.47

## tables

### Users table

|Colummn|type|Optionals|
|-------|----|---------|
|nickname|string|null:false|
|password|string|null:false|
|email|string|null:false|
|first_name|string|null:false|
|last_name|string|null:false|
|first_name_kana|string|null:false|
|last_name_kana|string|null:false|
|tel|string|null:false|
|birth|date|null:false|
|description|text||

#### Association
- has_many:items,dependent:destroy
- has_many:creditcards,dependent:destroy
- has_many:destinations,dependent:destroy

### Items table

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
|size|string|null:false|
|contition|string|null:false|
|preparation|string|null:false|
|postage|string|null:false|
|user_id|references|null:false|
|status|string|null:false|

#### Association
- belongs_to:user
- has_many:itemimages,dependent:destroy
- belongs_to:prefecture
- belongs_to:category
- belongs_to:brand

### CreditCards table

|Colummn|type|Optionals|
|-------|----|---------|
|user_id|references|null:false,foreign_key:true|
|payjp_custumer_id|string|null:false|
|payjp_card_id|string|null:false|

#### Association
- belongs_to:user

### Destinations table

|Colummn|type|Optionals|
|-------|----|---------|
|user_id|references|null:false,foreign_key:true|
|post_code|string|null:false|
|prefecture_id|string|null:false,foreign_key:true|
|city|string|null:false|
|block_num|string||
|first_name|string|null:false|
|last_name|string|null:false|

#### Association
- belongs_to:user
- belongs_to:prefecture

### Prefectures table/Active_hash

|Colummn|type|Optionals|
|-------|----|---------|
|name|string|null:false|

#### Association
- has_many:destinations
- has_many:items

### ItemImages table

|Colummn|type|Optionals|
|-------|----|---------|
|item_id|references|null:false,foreign_key:true|
|image|string|null:false|

#### Association
- belongs_to:item

### Categories table/Active_hash

|Colummn|type|Optionals|
|-------|----|---------|
|name|string|null:false|
|path|string||

#### Association
- has_many:items
- has_ancestry

### Brands table/Active_hash


|Colummn|type|Optionals|
|-------|----|---------|
|name|string|null:false|

#### Association
- has_many:items