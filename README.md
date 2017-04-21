# DB設計

## users table

| column                | Type   | Options                  |
|:----------------------|:------:|:-------------------------|
| name                  | string | unique:true, null: false |


### association

belongs_to :group  
has_many :group_members, as: :content


## groups table

| column                | Type   | Options                  |
|:----------------------|:------:|:-------------------------|
| name                  | string | unique:true, null: false |


### association

has_many :users  
has_many :group_menbers


## members table

| column             | Type    | Options             |
|:-------------------|:-------:|:--------------------|
| user_id            | integer | foreign_key :true   |
| group_id           | integer | foreign_key :true   |


### association

belongs_to :group  
belongs_to :user


## messages table

| column          | Type    | Options             |
|:----------------|:-------:|:--------------------|
| text            | text    | null: false         |
| member_id       | integer | foreign_key :true   |
| group_id        | integer | foreign_key :true   |

### association

belongs_to :member  
belongs_to :group