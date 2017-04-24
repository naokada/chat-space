# DB設計

## users table

| column                | Type   | Options                  |
|:----------------------|:------:|:-------------------------|
| name                  | string | unique:true, null: false |


### association

belongs_to :group, through: :groups_users  
has_many :group_members
has_many :messages


## groups table

| column                | Type   | Options                  |
|:----------------------|:------:|:-------------------------|
| name                  | string | unique:true, null: false |


### association

has_many :users, through: :groups_users  
has_many :groups_users
has_many :messages


## groups_users table

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
| body            | text    | null: false         |
| image           | string  |                     |
| user_id         | integer | foreign_key :true   |
| group_id        | integer | foreign_key :true   |

### association

belongs_to :user  
belongs_to :group