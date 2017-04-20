# DB設計

## users table

string :name
string :email
string :password
string :password_confirmation

| column                | Type   | Options                  |
|:----------------------|:------:|:-------------------------|
| name                  | string | null: false              |
| email                 | steing | unique:true, null: false |
| password              | string | null: false              |
| password_confirmation | string | null: false              |


### association

belongs_to :group
has_many :group_members, as: :content


## groups table

| column                | Type   | Options             |
|:----------------------|:------:|:--------------------|
| name                  | string | null: false         |


### association

has_many :users
has_many :group_menbers


## group_members table

| column                | Type    | Options             |
|:----------------------|:-------:|:--------------------|
| content_id            | integer |                     |
| content_type          | string  |                     |


### association

belongs_to :content, polymorphic: true


## messages table

| column          | Type    | Options             |
|:----------------|:-------:|:--------------------|
| text            | text    |null: false          |
| user_id         | integer |                     |
| group_id        | integer |                     |

### association

belongs_to :user
belongs_to :group