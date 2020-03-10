crumb :root do
  link "Home", root_path
end

# マイページ
crumb :mypages do
  link "マイページ", mypage_path(id: current_user.id)
  parent :root
end

crumb :status do
  link "出品した商品-出品中", status_mypages_path(aasm_state:"selling")
  parent :mypages
end

# ログアウト
crumb :logout do
  link "ログアウト", logout_mypages_path
  parent :mypages
end

# カテゴリー
crumb :categories do
  link "カテゴリー", categories_path
end


# 検索画面
crumb :search do |name|
  @search = params[:search]
  link @search, searches_path
  parent :root
end

# ビューページを実装したらコメントアウトを外します
# # プロフィール
# crumb :profile do
#   link "プロフィール", edit_user_path
#   parent :mypage
# end

# 商品詳細ページ
# カテゴリやコントローラの設定が完了していないためfindでidを指定して表示できるようにしています
crumb :item do |item|
  link "#{item.name}", item_path(item)
  parent :root
end

