class CreateRelationships < ActiveRecord::Migration[5.2]
  
  def change
    create_table :relationships do |t|
  
    #中間テーブルなので、データ型はreferences。外部キーとして設定するため、オプションで指定
      t.references :user, foreign_key: true
    
    #follow_idの参照先として、usersテーブルを指定
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps

    #重複してフォローされないようにする
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
